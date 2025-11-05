看到您的使用者權限結構，這是一個典型需要優化的案例。目前有超過 150 個 `power_*` 欄位，這會造成以下問題：

## 🔍 目前設計的問題

1. **擴展性差**：每次新增權限都要修改資料庫結構
2. **維護困難**：欄位太多，難以管理
3. **查詢複雜**：權限檢查需要查詢大量欄位
4. **缺乏彈性**：無法動態調整權限組合

## ✨ 建議的優化方案

我建議採用 **RBAC (Role-Based Access Control)** 模型，將權限系統重構為以下結構：

### 1. 新的資料庫架構

```sql
-- 使用者表（簡化版）
CREATE TABLE users (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  login_id VARCHAR(255) NOT NULL UNIQUE,
  password VARCHAR(255) NOT NULL,
  name VARCHAR(255),
  email VARCHAR(255),
  pic VARCHAR(255),
  profile TEXT,
  status ENUM('active', 'inactive', 'expired') DEFAULT 'active',
  expiration_date DATE NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  last_login_at TIMESTAMP NULL,
  INDEX idx_login_id (login_id),
  INDEX idx_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 角色表
CREATE TABLE roles (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL UNIQUE,
  display_name VARCHAR(255) NOT NULL,
  description TEXT,
  is_system TINYINT(1) DEFAULT 0 COMMENT '系統預設角色不可刪除',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_name (name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 權限表
CREATE TABLE permissions (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL UNIQUE COMMENT '權限識別碼，如 product.view',
  display_name VARCHAR(255) NOT NULL,
  description TEXT,
  module VARCHAR(50) NOT NULL COMMENT '模組名稱，如 product, finance, member',
  category VARCHAR(50) COMMENT '分類，如 tw, sg, mm',
  action VARCHAR(50) NOT NULL COMMENT '動作，如 view, create, edit, delete',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_name (name),
  INDEX idx_module (module),
  INDEX idx_category (category)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 使用者-角色關聯表
CREATE TABLE user_roles (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  user_id BIGINT UNSIGNED NOT NULL,
  role_id INT UNSIGNED NOT NULL,
  granted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  granted_by BIGINT UNSIGNED NULL COMMENT '授權者ID',
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (role_id) REFERENCES roles(id) ON DELETE CASCADE,
  UNIQUE KEY unique_user_role (user_id, role_id),
  INDEX idx_user_id (user_id),
  INDEX idx_role_id (role_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 角色-權限關聯表
CREATE TABLE role_permissions (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  role_id INT UNSIGNED NOT NULL,
  permission_id INT UNSIGNED NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (role_id) REFERENCES roles(id) ON DELETE CASCADE,
  FOREIGN KEY (permission_id) REFERENCES permissions(id) ON DELETE CASCADE,
  UNIQUE KEY unique_role_permission (role_id, permission_id),
  INDEX idx_role_id (role_id),
  INDEX idx_permission_id (permission_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 使用者直接權限表（特殊情況使用）
CREATE TABLE user_permissions (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  user_id BIGINT UNSIGNED NOT NULL,
  permission_id INT UNSIGNED NOT NULL,
  is_granted TINYINT(1) DEFAULT 1 COMMENT '1=授予, 0=撤銷（覆蓋角色權限）',
  granted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  granted_by BIGINT UNSIGNED NULL,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (permission_id) REFERENCES permissions(id) ON DELETE CASCADE,
  UNIQUE KEY unique_user_permission (user_id, permission_id),
  INDEX idx_user_id (user_id),
  INDEX idx_permission_id (permission_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 備註表（將原本的三個備註欄位獨立出來）
CREATE TABLE user_notes (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  user_id BIGINT UNSIGNED NOT NULL,
  note_type ENUM('finance', 'deliver', 'purchase') NOT NULL,
  content LONGTEXT,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  UNIQUE KEY unique_user_note_type (user_id, note_type)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
```

### 2. 權限命名規範

採用 `module.category.action` 的格式：

```
產品管理相關：
- product.view (查看產品)
- product.tw.edit (編輯台灣產品)
- product.sg.edit (編輯新加坡產品)
- product.mm.edit (編輯緬甸產品)

財務管理相關：
- finance.view (查看財務)
- finance.s2t.view (新加坡到台灣)
- finance.s2t.print_hint (列印提示)
- finance.s2t.goods_reference (商品參考)

採購管理相關：
- purchase.view
- purchase.b2s.view
- purchase.b2s.print_hint

會員管理相關：
- member.view
- member.sg.view
- member.mm.view
- member.rent.view
```

### 3. 初始資料範例

```sql
-- 插入基本角色
INSERT INTO roles (name, display_name, description, is_system) VALUES
('super_admin', '超級管理員', '擁有所有權限', 1),
('admin', '管理員', '一般管理員權限', 1),
('finance_manager', '財務主管', '財務相關完整權限', 0),
('product_manager', '產品主管', '產品管理完整權限', 0),
('sales', '業務人員', '基本銷售權限', 0),
('viewer', '訪客', '僅查看權限', 0);

-- 插入權限（範例）
INSERT INTO permissions (name, display_name, module, category, action, description) VALUES
-- 產品相關
('product.view', '查看產品', 'product', NULL, 'view', '查看產品列表'),
('product.create', '新增產品', 'product', NULL, 'create', '新增產品資料'),
('product.tw.manage', '管理台灣產品', 'product', 'tw', 'manage', '完整管理台灣區產品'),
('product.sg.manage', '管理新加坡產品', 'product', 'sg', 'manage', '完整管理新加坡區產品'),
('product.mm.manage', '管理緬甸產品', 'product', 'mm', 'manage', '完整管理緬甸區產品'),

-- 財務相關
('finance.view', '查看財務', 'finance', NULL, 'view', '查看財務資料'),
('finance.s2t.view', '查看新加坡到台灣', 'finance', 's2t', 'view', ''),
('finance.s2t.print', '列印新加坡到台灣', 'finance', 's2t', 'print', ''),
('finance.s2t.print_hint', '列印提示', 'finance', 's2t', 'print_hint', ''),

-- 會員相關
('member.view', '查看會員', 'member', NULL, 'view', ''),
('member.sg.manage', '管理新加坡會員', 'member', 'sg', 'manage', ''),
('member.mm.manage', '管理緬甸會員', 'member', 'mm', 'manage', ''),

-- 系統相關
('system.manage', '系統管理', 'system', NULL, 'manage', '系統設定管理'),
('user.manage', '使用者管理', 'user', NULL, 'manage', '管理使用者帳號');

-- 設定超級管理員角色的所有權限
INSERT INTO role_permissions (role_id, permission_id)
SELECT 1, id FROM permissions;
```

### 4. 建立 TypeScript 類型定義

讓我更新您的類型定義檔：

[2 tools called]

現在讓我創建幾個實用的檔案來幫助您實作新的權限系統：

### 5. 建立權限檢查 Composable

[1 tool called]

### 6. 建立資料遷移腳本

[1 tool called]

### 7. 建立完整的 SQL 遷移檔案

[2 tools called]

現在讓我創建一個範例元件，展示如何在實際應用中使用新的權限系統：

[2 tools called]

現在讓我檢查是否有任何錯誤需要修正：

[1 tool called]

讓我修正這些錯誤：

[10 tools called]

完美！所有錯誤都已修正。現在讓我創建一個總結文檔：

[1 tool called]

最後，讓我創建一個實用的權限映射腳本，幫助您從舊系統遷移：

[1 tool called]

完成了！我已經為您建立了一套完整的權限系統優化方案。以下是詳細說明：

## 🎯 優化方案總覽

### 原系統的問題
您目前的系統有 **150+ 個 `power_*` 欄位**，這造成了：
- ❌ 資料庫結構複雜，難以維護
- ❌ 每次新增權限都要改資料表結構（ALTER TABLE）
- ❌ 無法靈活組合權限
- ❌ 缺乏權限變更歷史記錄

### 新系統的優勢
採用 **RBAC (Role-Based Access Control)** 架構：
- ✅ 只需 **6 個資料表** 取代 150+ 個欄位
- ✅ 新增權限只要 INSERT，不用改資料表結構
- ✅ 靈活的角色和權限組合
- ✅ 完整的授權記錄追蹤
- ✅ 支援權限繼承和覆蓋

## 📁 我為您建立的檔案

### 1. **資料庫相關**
- **`database_rbac_schema.sql`** - 完整的新資料庫結構
  - 包含 6 個主要資料表
  - 2 個視圖方便查詢
  - 預設的角色和權限資料

- **`migration_script.sql`** - 自動化遷移腳本
  - 自動將舊資料遷移到新系統
  - 包含權限映射邏輯
  - 提供遷移驗證查詢

### 2. **前端類型定義**
- **`admin/app/types/index.d.ts`** - TypeScript 類型定義
  - User, Role, Permission 等介面
  - 表單和 API 回應類型
  - 包含舊系統相容類型

### 3. **前端工具**
- **`admin/app/composables/usePermission.ts`** - 權限檢查工具
  ```typescript
  const permission = usePermission()
  
  // 檢查權限
  permission.hasPermission('product.view')
  
  // 檢查區域權限
  permission.hasRegionPermission('product', 'sg', 'edit')
  
  // 取得可訪問的區域
  permission.getAccessibleRegions('product') // ['tw', 'sg']
  ```

- **`admin/app/components/PermissionGuard.vue`** - 權限守衛元件
  ```vue
  <PermissionGuard permission="product.view">
    <ProductList />
  </PermissionGuard>
  ```

### 4. **文檔**
- **`PERMISSION_SYSTEM_SUMMARY.md`** - 系統總覽
- **`MIGRATION_GUIDE.md`** - 詳細的遷移步驟指南
- **`PERMISSION_USAGE_EXAMPLES.md`** - 實際使用範例

## 🗄️ 新的資料庫結構

```
users (使用者)
  ├── 基本資料 (login_id, name, email, status...)
  └── 關聯: roles, permissions, notes

roles (角色)
  ├── 預設角色：super_admin, admin, finance_manager...
  └── 可自由新增角色

permissions (權限)
  ├── 採用 module.category.action 命名
  └── 範例：product.sg.manage, finance.s2t.view

user_roles (使用者-角色)
user_permissions (使用者-權限，可覆蓋角色權限)
user_notes (使用者備註)
```

## 🔐 權限命名範例

基於您的原系統，我已經映射好權限命名：

```
舊欄位 → 新權限

power_product = 28 → product.view + product.create + product.edit
power_product_sg = 28 → product.sg.manage
power_product_mm = 28 → product.mm.manage

power_finance = 28 → finance.view + finance.edit
power_finance_s2t = 28 → finance.s2t.view + finance.s2t.edit
power_finance_s2t_print_hint = 1 → finance.s2t.print_hint

power_member_singapore = 28 → member.sg.manage
power_member_myanmar = 28 → member.mm.manage
```

## 📋 使用範例

### 在 Vue 元件中
```vue
<script setup lang="ts">
const permission = usePermission()

// 取得使用者可訪問的區域
const regions = permission.getAccessibleRegions('product')
</script>

<template>
  <!-- 根據權限顯示按鈕 -->
  <UButton 
    v-if="permission.hasPermission('product.create')"
    @click="createProduct"
  >
    新增產品
  </UButton>

  <!-- 使用守衛元件 -->
  <PermissionGuard permission="finance.s2t.view">
    <FinanceS2TList />
  </PermissionGuard>

  <!-- 檢查新加坡產品編輯權限 -->
  <UButton
    v-if="permission.hasRegionPermission('product', 'sg', 'edit')"
  >
    編輯新加坡產品
  </UButton>
</template>
```

## 🚀 遷移步驟

1. **建立新資料表**
   ```bash
   mysql -u root -p your_database < database_rbac_schema.sql
   ```

2. **執行遷移腳本**
   ```bash
   mysql -u root -p your_database < migration_script.sql
   ```

3. **更新 API** - 實作權限檢查邏輯

4. **更新前端** - 使用新的 composable 和元件

5. **測試驗證** - 確認所有功能正常

## 💡 主要優勢

1. **容易擴展**：新增權限只需 INSERT，不用改資料表
2. **靈活組合**：可以建立各種角色組合
3. **細緻控制**：可以針對區域（台灣/新加坡/緬甸）設定不同權限
4. **完整記錄**：追蹤誰在何時授予了什麼權限
5. **效能更好**：透過索引和視圖優化查詢

## 📚 建議閱讀順序

1. 先看 **`PERMISSION_SYSTEM_SUMMARY.md`** 了解整體架構
2. 閱讀 **`MIGRATION_GUIDE.md`** 了解遷移步驟
3. 參考 **`PERMISSION_USAGE_EXAMPLES.md`** 學習如何使用
4. 執行 **`database_rbac_schema.sql`** 建立資料表
5. 根據需要調整 **`migration_script.sql`** 並執行

所有檔案都已經準備好了，您可以根據實際情況進行調整和使用。如果有任何問題或需要進一步的協助，請隨時告訴我！ 🎉