# 權限系統優化總結

## 📌 概述

本次優化將原有的 **150+ 個 `power_*` 欄位** 的權限系統重構為現代化的 **RBAC (Role-Based Access Control)** 系統。

## 🎯 優化目標

### 原系統問題
- ❌ 150+ 個 `power_*` 欄位，難以維護
- ❌ 每次新增權限需要修改資料庫結構 (ALTER TABLE)
- ❌ 無法靈活組合權限
- ❌ 缺乏權限變更追蹤
- ❌ 查詢複雜且效能不佳

### 新系統優勢
- ✅ 5 個清晰的資料表結構
- ✅ 新增權限只需 INSERT，無需改結構
- ✅ 靈活的角色和權限組合
- ✅ 完整的變更記錄 (granted_by, granted_at)
- ✅ 高效的權限查詢和檢查
- ✅ 支援權限繼承和覆蓋

## 📁 已建立的檔案

### 1. 資料庫相關
- **`database_rbac_schema.sql`** - 完整的資料庫架構
  - 6 個主要資料表
  - 2 個視圖 (View)
  - 預設角色和權限資料

### 2. TypeScript 類型定義
- **`admin/app/types/index.d.ts`** - 完整的類型定義
  - User, Role, Permission 介面
  - 表單和 API 回應類型
  - 舊系統遷移類型

### 3. Composables
- **`admin/app/composables/usePermission.ts`** - 權限檢查工具
  - 基本權限檢查方法
  - 模組權限檢查
  - 區域權限檢查
  - 角色檢查

### 4. Vue 元件
- **`admin/app/components/PermissionGuard.vue`** - 權限守衛元件
  - 支援權限和角色檢查
  - 可自訂無權限時的顯示內容

### 5. 文檔
- **`MIGRATION_GUIDE.md`** - 完整的遷移指南
  - 步驟化遷移流程
  - 權限映射說明
  - SQL 腳本範例
  
- **`PERMISSION_USAGE_EXAMPLES.md`** - 使用範例
  - Vue 元件中的使用方法
  - API 控制器範例
  - 常見使用場景

## 🗄️ 資料庫結構

### 核心資料表

```
users (使用者表)
├── id
├── login_id
├── password
├── name
├── status (active/inactive/expired)
└── ...

roles (角色表)
├── id
├── name (識別名稱)
├── display_name (顯示名稱)
└── is_system (是否系統預設)

permissions (權限表)
├── id
├── name (如: product.view)
├── display_name
├── module (模組)
├── category (分類)
└── action (動作)

user_roles (使用者-角色關聯)
├── user_id
├── role_id
└── granted_by

role_permissions (角色-權限關聯)
├── role_id
└── permission_id

user_permissions (使用者直接權限)
├── user_id
├── permission_id
├── is_granted (授予/撤銷)
└── granted_by

user_notes (使用者備註)
├── user_id
├── note_type (finance/deliver/purchase)
└── content
```

## 🔐 權限命名規範

採用 `module.category.action` 格式：

```
產品管理：
- product.view
- product.create
- product.edit
- product.tw.manage
- product.sg.manage
- product.mm.manage

財務管理：
- finance.view
- finance.s2t.view
- finance.s2t.print
- finance.s2t.print_hint

會員管理：
- member.view
- member.sg.manage
- member.mm.manage
```

## 💻 使用範例

### 1. 在 Vue 元件中檢查權限

```vue
<script setup lang="ts">
const permission = usePermission()
</script>

<template>
  <!-- 方式 1: 直接使用 composable -->
  <UButton 
    v-if="permission.hasPermission('product.create')"
    @click="createProduct"
  >
    新增產品
  </UButton>

  <!-- 方式 2: 使用 PermissionGuard 元件 -->
  <PermissionGuard permission="product.view">
    <ProductList />
  </PermissionGuard>

  <!-- 方式 3: 檢查區域權限 -->
  <UButton
    v-if="permission.hasRegionPermission('product', 'sg', 'edit')"
    @click="editSGProduct"
  >
    編輯新加坡產品
  </UButton>

  <!-- 方式 4: 檢查角色 -->
  <div v-if="permission.hasRole('super_admin')">
    管理員專用功能
  </div>
</template>
```

### 2. 取得使用者可訪問的區域

```typescript
const permission = usePermission()

// 取得使用者在產品模組可訪問的區域
const accessibleRegions = permission.getAccessibleRegions('product')
// 返回: ['tw', 'sg'] 或 ['mm'] 等
```

### 3. 檢查模組權限

```typescript
// 檢查是否有財務模組的任何權限
if (permission.hasAnyModulePermission('finance')) {
  // 顯示財務選單
}

// 取得使用者在財務模組的所有權限
const financePerms = permission.getModulePermissions('finance')
// 返回: ['finance.view', 'finance.s2t.view', ...]
```

## 📋 預設角色

系統預設建立以下角色：

1. **super_admin** - 超級管理員（擁有所有權限）
2. **admin** - 一般管理員
3. **finance_manager_tw** - 台灣財務主管
4. **finance_manager_sg** - 新加坡財務主管
5. **finance_manager_mm** - 緬甸財務主管
6. **product_manager** - 產品主管
7. **purchase_manager** - 採購主管
8. **deliver_manager** - 出貨主管
9. **sales_tw/sg/mm** - 各區業務
10. **warehouse_tw/sg/mm** - 各區倉管
11. **member_service** - 會員服務
12. **viewer** - 訪客（僅查看）

## 🔄 遷移流程

### 步驟 1: 建立新資料表
```bash
mysql -u root -p your_database < database_rbac_schema.sql
```

### 步驟 2: 分析舊權限並映射
```sql
-- 範例：將 power_product = 28 映射為
INSERT INTO user_permissions (user_id, permission_id)
SELECT user_id, id FROM permissions 
WHERE name IN ('product.view', 'product.create', 'product.edit');
```

### 步驟 3: 執行資料遷移
- 遷移使用者基本資料
- 遷移備註資料
- 根據舊的 power_* 值分配新權限

### 步驟 4: 更新 API
- 實作 `getUserPermissions()` 方法
- 在控制器中加入權限檢查
- 更新 JWT payload 包含角色和權限

### 步驟 5: 更新前端
- 使用新的 `usePermission` composable
- 使用 `PermissionGuard` 元件
- 更新選單和頁面權限檢查

### 步驟 6: 測試驗證
- 測試各種權限組合
- 確認舊使用者權限正確遷移
- 驗證新的權限檢查機制

## 🎨 元件 API

### usePermission Composable

```typescript
const permission = usePermission()

// 基本檢查
permission.hasPermission(permission: string | string[]): boolean
permission.hasAnyPermission(permissions: string[]): boolean
permission.hasAllPermissions(permissions: string[]): boolean

permission.hasRole(role: string | string[]): boolean
permission.hasAnyRole(roles: string[]): boolean
permission.hasAllRoles(roles: string[]): boolean

permission.isSuperAdmin(): boolean

// 模組檢查
permission.hasModulePermission(module, action, category?): boolean
permission.hasAnyModulePermission(module): boolean
permission.getModulePermissions(module): string[]

// 區域檢查
permission.hasRegionPermission(module, region, action): boolean
permission.getAccessibleRegions(module): ('tw'|'sg'|'mm')[]

// 獲取資訊
permission.getUserPermissions(): string[]
permission.getUserRoles(): string[]
```

### PermissionGuard 元件

```vue
<PermissionGuard
  permission="product.view"        // 單一權限
  :permissions="['p1', 'p2']"     // 多個權限
  require-all                      // 需要全部權限
  role="admin"                     // 角色檢查
  :roles="['admin', 'manager']"   // 多個角色
  require-all-roles               // 需要全部角色
  fallback                         // 顯示無權限訊息
>
  <div>受保護的內容</div>
  
  <template #fallback>
    <div>自訂無權限訊息</div>
  </template>
</PermissionGuard>
```

## 📊 效能優化

### 1. 使用視圖簡化查詢
```sql
-- v_user_all_permissions 視圖
-- 合併角色權限和直接權限
SELECT * FROM v_user_all_permissions WHERE user_id = 12;
```

### 2. 建立適當索引
```sql
-- 已在 schema 中建立的索引
- users: idx_login_id, idx_status
- permissions: idx_name, idx_module, idx_category
- user_roles: idx_user_id, idx_role_id
- role_permissions: idx_role_id, idx_permission_id
```

### 3. 快取權限資料
```typescript
// 在登入時載入使用者權限，存入 JWT 或 session
// 前端快取在 auth store 中
```

## 🔧 維護建議

1. **定期審查權限**
   - 每季度檢查權限配置
   - 移除不需要的權限
   - 更新角色定義

2. **記錄變更**
   - 使用 `granted_by` 追蹤誰修改了權限
   - 考慮建立權限變更日誌表

3. **角色優先**
   - 優先使用角色管理權限
   - 直接權限僅用於特殊情況

4. **最小權限原則**
   - 只給予必要的權限
   - 定期檢查使用者的實際需求

5. **測試環境驗證**
   - 新的權限配置先在測試環境驗證
   - 使用不同角色的測試帳號

## 📈 未來擴展

### 可能的增強功能

1. **權限有效期**
   ```sql
   ALTER TABLE user_permissions 
   ADD COLUMN expires_at TIMESTAMP NULL;
   ```

2. **權限組 (Permission Groups)**
   ```sql
   CREATE TABLE permission_groups (
     id INT PRIMARY KEY,
     name VARCHAR(100),
     permissions JSON
   );
   ```

3. **條件權限 (Conditional Permissions)**
   - 根據時間、IP、或其他條件限制權限

4. **權限委派**
   - 允許主管臨時委派權限給下屬

5. **審計日誌**
   ```sql
   CREATE TABLE permission_audit_log (
     id BIGINT PRIMARY KEY,
     user_id BIGINT,
     action VARCHAR(50),
     permission_name VARCHAR(100),
     changed_by BIGINT,
     created_at TIMESTAMP
   );
   ```

## 🆘 疑難排解

### Q1: 使用者權限沒有立即生效？
**A:** 權限資訊通常在登入時載入到 JWT token。需要重新登入或實作權限刷新機制。

### Q2: 如何快速測試不同權限？
**A:** 
- 開發環境：暫時給自己 super_admin 角色
- 建立測試用角色和帳號
- 使用工具切換使用者身份

### Q3: 遷移後某些功能無法使用？
**A:** 
1. 檢查權限映射是否正確
2. 查看 API 端的權限檢查邏輯
3. 使用 `getUserPermissions()` 確認使用者實際權限

### Q4: 如何批量設定權限？
**A:**
```sql
-- 給所有產品主管添加新權限
INSERT INTO role_permissions (role_id, permission_id)
SELECT 
  (SELECT id FROM roles WHERE name = 'product_manager'),
  id 
FROM permissions 
WHERE module = 'product' AND action = 'export';
```

### Q5: 舊資料如何保留？
**A:** 
- 保留原 `sys_loginsystem` 表
- 新舊系統可並行運作一段時間
- 確認穩定後再刪除舊表

## 📚 相關文件

- 📖 [MIGRATION_GUIDE.md](./MIGRATION_GUIDE.md) - 詳細遷移指南
- 💡 [PERMISSION_USAGE_EXAMPLES.md](./PERMISSION_USAGE_EXAMPLES.md) - 使用範例
- 🗄️ [database_rbac_schema.sql](./database_rbac_schema.sql) - 資料庫架構

## ✅ 檢查清單

遷移完成後請確認：

- [ ] 新資料表已建立
- [ ] 權限資料已匯入
- [ ] 角色已設定
- [ ] 使用者資料已遷移
- [ ] 使用者權限已正確分配
- [ ] API 權限檢查已更新
- [ ] 前端權限檢查已更新
- [ ] 測試各種權限組合
- [ ] 確認所有功能正常運作
- [ ] 舊表已備份
- [ ] 文檔已更新

## 🎉 總結

透過此次優化，權限系統從：
- **150+ 個欄位** → **5 個資料表**
- **硬編碼權限** → **動態權限管理**
- **難以維護** → **清晰且靈活**
- **無法追蹤** → **完整的變更記錄**

新系統不僅更容易維護，也為未來的擴展奠定了良好的基礎。

---

如有任何問題或需要協助，請參考相關文件或聯絡技術團隊。

