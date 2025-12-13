# 權限系統遷移指南

本指南將協助您從舊的權限系統（150+ power_* 欄位）遷移到新的 RBAC 系統。

## 📋 遷移步驟

### 步驟 1: 建立新的資料庫結構

執行 `database/migrations/create_rbac_tables.sql` 建立新的資料表。

### 步驟 2: 分析並映射權限

首先，我們需要將舊的 150+ 個 power_* 欄位映射到新的權限系統。

#### 舊系統權限欄位分析

```
power_product (產品管理)
power_product_sg (新加坡產品)
power_product_mm (緬甸產品)
power_member (會員管理)
power_finance (財務管理)
power_finance_s2t (新加坡到台灣)
...等超過 150 個欄位
```

#### 映射到新權限系統

```sql
-- 產品管理權限
power_product = 28 -> product.view + product.create + product.edit + product.delete
power_product_sg = 28 -> product.sg.manage
power_product_mm = 28 -> product.mm.manage

-- 會員管理權限
power_member = 28 -> member.view + member.create + member.edit
power_member_singapore = 28 -> member.sg.manage
power_member_myanmar = 28 -> member.mm.manage

-- 財務管理權限
power_finance = 28 -> finance.view + finance.edit
power_finance_s2t = 28 -> finance.s2t.view + finance.s2t.edit
power_finance_s2t_print_hint = 1 -> finance.s2t.print_hint
power_finance_s2t_goods_reference = 1 -> finance.s2t.goods_reference
```

### 步驟 3: 插入權限資料

```sql
-- 插入所有權限定義
INSERT INTO permissions (name, display_name, module, category, action, description) VALUES

-- === 產品管理模組 ===
('product.view', '查看產品', 'product', NULL, 'view', '查看產品列表和詳情'),
('product.create', '新增產品', 'product', NULL, 'create', '新增產品資料'),
('product.edit', '編輯產品', 'product', NULL, 'edit', '編輯產品資料'),
('product.delete', '刪除產品', 'product', NULL, 'delete', '刪除產品'),
('product.tw.manage', '管理台灣產品', 'product', 'tw', 'manage', '完整管理台灣區產品'),
('product.sg.manage', '管理新加坡產品', 'product', 'sg', 'manage', '完整管理新加坡區產品'),
('product.mm.manage', '管理緬甸產品', 'product', 'mm', 'manage', '完整管理緬甸區產品'),
('product.keyin', '產品輸入', 'product', NULL, 'keyin', '新增產品輸入'),

-- === 會員管理模組 ===
('member.view', '查看會員', 'member', NULL, 'view', '查看會員資料'),
('member.create', '新增會員', 'member', NULL, 'create', '新增會員'),
('member.edit', '編輯會員', 'member', NULL, 'edit', '編輯會員資料'),
('member.delete', '刪除會員', 'member', NULL, 'delete', '刪除會員'),
('member.sg.manage', '管理新加坡會員', 'member', 'sg', 'manage', ''),
('member.mm.manage', '管理緬甸會員', 'member', 'mm', 'manage', ''),
('member.rent.view', '查看租賃會員', 'member', 'rent', 'view', ''),
('member.rent.sg.manage', '管理新加坡租賃會員', 'member', 'rent_sg', 'manage', ''),
('member.rent.mm.manage', '管理緬甸租賃會員', 'member', 'rent_mm', 'manage', ''),

-- === 財務管理模組 ===
('finance.view', '查看財務', 'finance', NULL, 'view', '查看財務報表'),
('finance.edit', '編輯財務', 'finance', NULL, 'edit', '編輯財務資料'),
('finance.delete', '刪除財務', 'finance', NULL, 'delete', '刪除財務記錄'),

-- 財務子類別 (新加坡到台灣)
('finance.s2t.view', '查看新加坡到台灣', 'finance', 's2t', 'view', ''),
('finance.s2t.edit', '編輯新加坡到台灣', 'finance', 's2t', 'edit', ''),
('finance.s2t.print', '列印新加坡到台灣', 'finance', 's2t', 'print', ''),
('finance.s2t.print_hint', '列印提示-新加坡到台灣', 'finance', 's2t', 'print_hint', ''),
('finance.s2t.goods_reference', '商品參考-新加坡到台灣', 'finance', 's2t', 'goods_reference', ''),
('finance.s2t.print_goods', '列印商品-新加坡到台灣', 'finance', 's2t', 'print_goods', ''),

-- 其他財務路線
('finance.s2y.view', '查看新加坡到緬甸', 'finance', 's2y', 'view', ''),
('finance.t2s.view', '查看台灣到新加坡', 'finance', 't2s', 'view', ''),
('finance.y2s.view', '查看緬甸到新加坡', 'finance', 'y2s', 'view', ''),
('finance.y2t.view', '查看緬甸到台灣', 'finance', 'y2t', 'view', ''),

-- 財務設定
('finance.setting.manage', '財務設定管理', 'finance', 'setting', 'manage', ''),

-- 財務轉帳
('finance.trans.tw', '台灣財務轉帳', 'finance', 'trans_tw', 'manage', ''),
('finance.trans.sg', '新加坡財務轉帳', 'finance', 'trans_sg', 'manage', ''),
('finance.trans.mm', '緬甸財務轉帳', 'finance', 'trans_mm', 'manage', ''),

-- === 預付財務管理 ===
('pre_finance.view', '查看預付財務', 'pre_finance', NULL, 'view', ''),
('pre_finance.s2t.view', '查看預付-新加坡到台灣', 'pre_finance', 's2t', 'view', ''),
('pre_finance.s2t.approve', '審核預付-新加坡到台灣', 'pre_finance', 's2t', 'approve', ''),
('pre_finance.s2t.print', '列印預付-新加坡到台灣', 'pre_finance', 's2t', 'print', ''),
('pre_finance.from_tw', '從台灣預付', 'pre_finance', 'from_tw', 'manage', ''),
('pre_finance.to_tw', '到台灣預付', 'pre_finance', 'to_tw', 'manage', ''),

-- === 出貨管理模組 ===
('deliver.view', '查看出貨', 'deliver', NULL, 'view', ''),
('deliver.create', '新增出貨', 'deliver', NULL, 'create', ''),
('deliver.edit', '編輯出貨', 'deliver', NULL, 'edit', ''),
('deliver.b2t.view', '查看出貨-B到T', 'deliver', 'b2t', 'view', ''),
('deliver.t2b.view', '查看出貨-T到B', 'deliver', 't2b', 'view', ''),
('deliver.new.s2t', '新增出貨-新加坡到台灣', 'deliver', 'new_s2t', 'create', ''),
('deliver.setting.manage', '出貨設定管理', 'deliver', 'setting', 'manage', ''),

-- === 採購管理模組 ===
('purchase.view', '查看採購', 'purchase', NULL, 'view', ''),
('purchase.create', '新增採購', 'purchase', NULL, 'create', ''),
('purchase.edit', '編輯採購', 'purchase', NULL, 'edit', ''),
('purchase.b2s.view', '查看採購-B到S', 'purchase', 'b2s', 'view', ''),
('purchase.b2t.view', '查看採購-B到T', 'purchase', 'b2t', 'view', ''),
('purchase.s2b.view', '查看採購-S到B', 'purchase', 's2b', 'view', ''),
('purchase.s2t.view', '查看採購-S到T', 'purchase', 's2t', 'view', ''),
('purchase.t2s.view', '查看採購-T到S', 'purchase', 't2s', 'view', ''),
('purchase.print_hint', '列印採購提示', 'purchase', NULL, 'print_hint', ''),
('purchase.keyin.sg', '採購輸入-新加坡', 'purchase', 'keyin_sg', 'create', ''),
('purchase.keyin.mm', '採購輸入-緬甸', 'purchase', 'keyin_mm', 'create', ''),

-- === 下載管理 ===
('download.manage', '下載管理', 'download', NULL, 'manage', ''),

-- === 系統管理 ===
('system.manage', '系統管理', 'system', NULL, 'manage', '系統設定'),
('user.view', '查看使用者', 'user', NULL, 'view', ''),
('user.manage', '管理使用者', 'user', NULL, 'manage', '管理使用者帳號'),

-- === 進出貨管理 ===
('in_out.view', '查看進出貨', 'in_out', NULL, 'view', ''),
('in_out.sg.manage', '管理新加坡進出貨', 'in_out', 'sg', 'manage', ''),
('in_out.mm.manage', '管理緬甸進出貨', 'in_out', 'mm', 'manage', ''),

-- === 設定管理 ===
('exchange.setting.manage', '匯率設定管理', 'exchange', 'setting', 'manage', ''),
('income_text.setting.manage', '收入文字設定', 'income_text', 'setting', 'manage', ''),
('feedback.setting.manage', '回饋設定管理', 'feedback', 'setting', 'manage', ''),

-- === 購物管理 ===
('shopping.manage', '購物管理', 'shopping', NULL, 'manage', ''),
('shopping.mm.manage', '緬甸購物管理', 'shopping', 'mm', 'manage', ''),

-- === POS 系統 ===
('pos.sale.report', 'POS銷售報表', 'pos', 'sale_report', 'view', ''),
('pos.sale.report.sg', 'POS銷售報表-新加坡', 'pos', 'sale_report_sg', 'view', ''),
('pos.sale.report.mm', 'POS銷售報表-緬甸', 'pos', 'sale_report_mm', 'view', ''),
('pos.expense', 'POS費用', 'pos', 'expense', 'manage', ''),
('pos.expense.sg', 'POS費用-新加坡', 'pos', 'expense_sg', 'manage', ''),
('pos.expense.mm', 'POS費用-緬甸', 'pos', 'expense_mm', 'manage', ''),
('pos.member.manage', 'POS會員管理', 'pos', 'member', 'manage', ''),
('pos.marquee', 'POS跑馬燈', 'pos', 'marquee', 'manage', ''),
('pos.marquee.sg', 'POS跑馬燈-新加坡', 'pos', 'marquee_sg', 'manage', ''),
('pos.marquee.mm', 'POS跑馬燈-緬甸', 'pos', 'marquee_mm', 'manage', ''),
('pos.cus_marquee', 'POS客戶跑馬燈', 'pos', 'cus_marquee', 'manage', ''),
('pos.store_income', 'POS門市收入', 'pos', 'store_income', 'manage', ''),
('pos.store_income.pim_in', 'POS門市收入-入', 'pos', 'store_income_pim_in', 'manage', ''),
('pos.store_income.pim_out', 'POS門市收入-出', 'pos', 'store_income_pim_out', 'manage', ''),
('pos.sale.system', 'POS銷售系統', 'pos', 'sale_system', 'manage', ''),
('pos.sale.system.sg', 'POS銷售系統-新加坡', 'pos', 'sale_system_sg', 'manage', ''),
('pos.sale.system.mm', 'POS銷售系統-緬甸', 'pos', 'sale_system_mm', 'manage', ''),
('pos.rtn.system', 'POS退貨系統', 'pos', 'rtn_system', 'manage', ''),
('pos.rtn.system.sg', 'POS退貨系統-新加坡', 'pos', 'rtn_system_sg', 'manage', ''),
('pos.rtn.system.mm', 'POS退貨系統-緬甸', 'pos', 'rtn_system_mm', 'manage', ''),

-- === 人事管理 ===
('staff.view', '查看員工', 'staff', NULL, 'view', ''),
('staff.modify', '修改員工', 'staff', NULL, 'edit', ''),
('staff.salary.input', '輸入員工薪資', 'staff', 'salary', 'input', ''),
('staff.print', '列印員工資料', 'staff', NULL, 'print', ''),

-- === POE 系統 ===
('poe.manage', 'POE管理', 'poe', NULL, 'manage', ''),
('poe.country', 'POE國家', 'poe', 'country', 'manage', ''),
('poe.exchange', 'POE匯率', 'poe', 'exchange', 'manage', ''),
('poe.bill.setting', 'POE帳單設定', 'poe', 'bill_setting', 'manage', ''),
('poe.stock.report', 'POE庫存報表', 'poe', 'stock_report', 'view', ''),
('poe.chat', 'POE對話', 'poe', 'chat', 'manage', ''),
('poe.print', 'POE列印', 'poe', NULL, 'print', ''),
('poe.admin', 'POE管理員', 'poe', 'admin', 'manage', ''),
('poe.chat.admin', 'POE對話管理員', 'poe', 'chat_admin', 'manage', ''),
('poe.customer.type', 'POE客戶類型', 'poe', 'customer_type', 'manage', ''),

-- === KTV 系統 ===
('ktv.manage', 'KTV管理', 'ktv', NULL, 'manage', ''),
('ktv.sg.manage', 'KTV管理-新加坡', 'ktv', 'sg', 'manage', ''),
('ktv.mm.manage', 'KTV管理-緬甸', 'ktv', 'mm', 'manage', ''),

-- === 計算機 ===
('cal.tw', '台灣計算機', 'calculator', 'tw', 'use', ''),
('cal.sg', '新加坡計算機', 'calculator', 'sg', 'use', ''),
('cal.mm', '緬甸計算機', 'calculator', 'mm', 'use', ''),

-- === 輪播圖管理 ===
('slide_show.tw', '台灣輪播圖', 'slide_show', 'tw', 'manage', ''),
('slide_show.sg', '新加坡輪播圖', 'slide_show', 'sg', 'manage', ''),
('slide_show.mm', '緬甸輪播圖', 'slide_show', 'mm', 'manage', '');
```

### 步驟 4: 建立預設角色

```sql
-- 插入預設角色
INSERT INTO roles (name, display_name, description, is_system) VALUES
('super_admin', '超級管理員', '擁有所有系統權限', 1),
('admin', '管理員', '一般管理員權限', 1),
('finance_manager_tw', '台灣財務主管', '台灣財務完整權限', 0),
('finance_manager_sg', '新加坡財務主管', '新加坡財務完整權限', 0),
('finance_manager_mm', '緬甸財務主管', '緬甸財務完整權限', 0),
('product_manager', '產品主管', '產品管理完整權限', 0),
('sales_tw', '台灣業務', '台灣銷售權限', 0),
('sales_sg', '新加坡業務', '新加坡銷售權限', 0),
('sales_mm', '緬甸業務', '緬甸銷售權限', 0),
('warehouse', '倉管人員', '倉庫管理權限', 0),
('viewer', '訪客', '僅查看權限', 0);

-- 設定超級管理員的所有權限
INSERT INTO role_permissions (role_id, permission_id)
SELECT 1, id FROM permissions;
```

### 步驟 5: 遷移使用者資料

```sql
-- 1. 遷移基本使用者資料
INSERT INTO users (
  id, 
  login_id, 
  password, 
  name, 
  email, 
  pic, 
  profile, 
  status, 
  expiration_date, 
  created_at, 
  updated_at, 
  last_login_at
)
SELECT 
  sysloginID,
  loginID,
  password,
  name,
  NULL as email,
  pic,
  profile,
  CASE 
    WHEN expiration_chk = 1 AND expiration_date < CURDATE() THEN 'expired'
    ELSE 'active'
  END as status,
  CASE WHEN expiration_date = '0000-00-00' THEN NULL ELSE expiration_date END,
  COALESCE(create_time, NOW()),
  COALESCE(update_time, NOW()),
  time as last_login_at
FROM sys_loginsystem;

-- 2. 遷移備註資料
INSERT INTO user_notes (user_id, note_type, content)
SELECT sysloginID, 'finance', note_finance
FROM sys_loginsystem
WHERE note_finance IS NOT NULL AND note_finance != '';

INSERT INTO user_notes (user_id, note_type, content)
SELECT sysloginID, 'deliver', note_deliver
FROM sys_loginsystem
WHERE note_deliver IS NOT NULL AND note_deliver != '';

INSERT INTO user_notes (user_id, note_type, content)
SELECT sysloginID, 'purchase', note_purchase
FROM sys_loginsystem
WHERE note_purchase IS NOT NULL AND note_purchase != '';
```

### 步驟 6: 遷移權限資料

這是最複雜的部分，需要根據舊的 power_* 欄位值來分配新的權限。

```sql
-- 建立臨時程序來處理權限遷移
DELIMITER $$

CREATE PROCEDURE migrate_user_permissions(IN user_id_param BIGINT)
BEGIN
  DECLARE done INT DEFAULT FALSE;
  DECLARE perm_id INT;
  
  -- 根據舊的 power_* 值來分配權限
  -- 這裡是一個範例，實際需要根據您的業務邏輯調整
  
  -- 產品管理權限 (power_product >= 1)
  IF (SELECT power_product FROM sys_loginsystem WHERE sysloginID = user_id_param) >= 1 THEN
    INSERT IGNORE INTO user_permissions (user_id, permission_id, is_granted)
    SELECT user_id_param, id, 1
    FROM permissions
    WHERE name IN ('product.view', 'product.create', 'product.edit');
  END IF;
  
  -- 新加坡產品 (power_product_sg >= 1)
  IF (SELECT power_product_sg FROM sys_loginsystem WHERE sysloginID = user_id_param) >= 1 THEN
    INSERT IGNORE INTO user_permissions (user_id, permission_id, is_granted)
    SELECT user_id_param, id, 1
    FROM permissions
    WHERE name = 'product.sg.manage';
  END IF;
  
  -- 緬甸產品 (power_product_mm >= 1)
  IF (SELECT power_product_mm FROM sys_loginsystem WHERE sysloginID = user_id_param) >= 1 THEN
    INSERT IGNORE INTO user_permissions (user_id, permission_id, is_granted)
    SELECT user_id_param, id, 1
    FROM permissions
    WHERE name = 'product.mm.manage';
  END IF;
  
  -- ... 繼續處理其他所有 power_* 欄位 ...
  
END$$

DELIMITER ;

-- 執行遷移
-- 對所有使用者執行權限遷移
CALL migrate_user_permissions(12); -- jeffery 的範例
```

### 步驟 7: 驗證遷移結果

```sql
-- 檢查使用者權限
SELECT 
  u.id,
  u.login_id,
  u.name,
  GROUP_CONCAT(DISTINCT r.display_name) as roles,
  COUNT(DISTINCT p.id) as permission_count
FROM users u
LEFT JOIN user_roles ur ON u.id = ur.user_id
LEFT JOIN roles r ON ur.role_id = r.id
LEFT JOIN user_permissions up ON u.id = up.user_id
LEFT JOIN permissions p ON up.permission_id = p.id
GROUP BY u.id;

-- 檢查特定使用者的所有權限
SELECT 
  u.login_id,
  p.module,
  p.name,
  p.display_name,
  'direct' as source
FROM users u
JOIN user_permissions up ON u.id = up.user_id
JOIN permissions p ON up.permission_id = p.id
WHERE u.id = 12

UNION

SELECT 
  u.login_id,
  p.module,
  p.name,
  p.display_name,
  CONCAT('role:', r.name) as source
FROM users u
JOIN user_roles ur ON u.id = ur.user_id
JOIN roles r ON ur.role_id = r.id
JOIN role_permissions rp ON r.id = rp.role_id
JOIN permissions p ON rp.permission_id = p.id
WHERE u.id = 12
ORDER BY module, name;
```

### 步驟 8: 更新 API

更新您的 CodeIgniter API 以支援新的權限系統。

### 步驟 9: 測試與驗證

1. 在測試環境完整測試所有功能
2. 確認每個使用者的權限正確
3. 測試權限檢查是否正常運作

### 步驟 10: 部署到生產環境

1. 備份舊資料庫
2. 執行遷移腳本
3. 切換到新系統
4. 保留舊表一段時間以備不時之需

## 🎯 優化效果

### 之前
- 150+ 個欄位
- 每次新增權限需要 ALTER TABLE
- 難以維護和理解
- 無法靈活組合權限

### 之後
- 5 個主要資料表
- 新增權限只需 INSERT
- 清晰的權限結構
- 靈活的角色和權限組合
- 支援權限繼承
- 可追蹤權限變更歷史

## 📚 使用範例

### 在程式碼中檢查權限

```typescript
// 在 Vue 元件中
const permission = usePermission()

// 檢查單一權限
if (permission.hasPermission('product.view')) {
  // 顯示產品列表
}

// 檢查模組權限
if (permission.hasModulePermission('finance', 'edit', 's2t')) {
  // 允許編輯新加坡到台灣的財務資料
}

// 檢查角色
if (permission.hasRole('super_admin')) {
  // 顯示管理選單
}

// 檢查區域權限
if (permission.hasRegionPermission('product', 'sg', 'manage')) {
  // 管理新加坡產品
}

// 取得可訪問的區域
const regions = permission.getAccessibleRegions('product')
// ['tw', 'sg']
```

### 在模板中使用

```vue
<template>
  <div v-if="permission.hasPermission('product.view')">
    <h1>產品列表</h1>
    
    <UButton 
      v-if="permission.hasPermission('product.create')"
      @click="createProduct"
    >
      新增產品
    </UButton>
  </div>
</template>

<script setup lang="ts">
const permission = usePermission()
</script>
```

## 🔧 維護建議

1. **定期審查權限**：每季度檢查權限設定是否合理
2. **記錄變更**：使用 granted_by 欄位追蹤誰修改了權限
3. **角色優先**：優先使用角色而非直接授權
4. **最小權限原則**：只給予必要的權限
5. **測試環境**：在測試環境先試驗新的權限配置

## ❓ 常見問題

### Q: 如何處理特殊權限需求？
A: 使用 `user_permissions` 表直接給使用者授予或撤銷特定權限。

### Q: 如何快速複製權限設定？
A: 建立一個新角色，將權限配置好後分配給多個使用者。

### Q: 舊系統的資料要保留嗎？
A: 建議保留 3-6 個月，確認新系統穩定後再刪除。

### Q: 如何回滾到舊系統？
A: 保留舊的 `sys_loginsystem` 表，需要時可以切回舊的 API 端點。

