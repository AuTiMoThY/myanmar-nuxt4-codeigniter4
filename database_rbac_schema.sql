-- ==========================================
-- 權限管理系統 (RBAC) 資料庫架構
-- ==========================================

-- 設定字元集
SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ==========================================
-- 1. 使用者表
-- ==========================================
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `login_id` VARCHAR(255) NOT NULL COMMENT '登入帳號',
  `password` VARCHAR(255) NOT NULL COMMENT '密碼',
  `name` VARCHAR(255) NOT NULL COMMENT '姓名',
  `email` VARCHAR(255) DEFAULT NULL COMMENT '電子信箱',
  `pic` VARCHAR(255) DEFAULT NULL COMMENT '頭像路徑',
  `profile` TEXT DEFAULT NULL COMMENT '個人簡介',
  `status` ENUM('active', 'inactive', 'expired') DEFAULT 'active' COMMENT '帳號狀態',
  `expiration_date` DATE DEFAULT NULL COMMENT '到期日',
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '建立時間',
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新時間',
  `last_login_at` TIMESTAMP NULL DEFAULT NULL COMMENT '最後登入時間',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_login_id` (`login_id`),
  KEY `idx_login_id` (`login_id`),
  KEY `idx_status` (`status`),
  KEY `idx_email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='使用者表';

-- ==========================================
-- 2. 角色表
-- ==========================================
DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL COMMENT '角色識別名稱 (英文)',
  `display_name` VARCHAR(255) NOT NULL COMMENT '角色顯示名稱',
  `description` TEXT DEFAULT NULL COMMENT '角色描述',
  `is_system` TINYINT(1) DEFAULT 0 COMMENT '是否為系統預設角色 (不可刪除)',
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_name` (`name`),
  KEY `idx_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='角色表';

-- ==========================================
-- 3. 權限表
-- ==========================================
DROP TABLE IF EXISTS `permissions`;
CREATE TABLE `permissions` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL COMMENT '權限識別名稱 (如: product.view)',
  `display_name` VARCHAR(255) NOT NULL COMMENT '權限顯示名稱',
  `description` TEXT DEFAULT NULL COMMENT '權限描述',
  `module` VARCHAR(50) NOT NULL COMMENT '所屬模組 (如: product, finance)',
  `category` VARCHAR(50) DEFAULT NULL COMMENT '分類 (如: tw, sg, mm, s2t)',
  `action` VARCHAR(50) NOT NULL COMMENT '動作 (如: view, create, edit, delete)',
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_name` (`name`),
  KEY `idx_name` (`name`),
  KEY `idx_module` (`module`),
  KEY `idx_category` (`category`),
  KEY `idx_module_category` (`module`, `category`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='權限表';

-- ==========================================
-- 4. 使用者-角色關聯表
-- ==========================================
DROP TABLE IF EXISTS `user_roles`;
CREATE TABLE `user_roles` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` BIGINT UNSIGNED NOT NULL COMMENT '使用者ID',
  `role_id` INT UNSIGNED NOT NULL COMMENT '角色ID',
  `granted_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '授權時間',
  `granted_by` BIGINT UNSIGNED DEFAULT NULL COMMENT '授權者ID',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_user_role` (`user_id`, `role_id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_role_id` (`role_id`),
  CONSTRAINT `fk_user_roles_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_user_roles_role` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='使用者-角色關聯表';

-- ==========================================
-- 5. 角色-權限關聯表
-- ==========================================
DROP TABLE IF EXISTS `role_permissions`;
CREATE TABLE `role_permissions` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `role_id` INT UNSIGNED NOT NULL COMMENT '角色ID',
  `permission_id` INT UNSIGNED NOT NULL COMMENT '權限ID',
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_role_permission` (`role_id`, `permission_id`),
  KEY `idx_role_id` (`role_id`),
  KEY `idx_permission_id` (`permission_id`),
  CONSTRAINT `fk_role_permissions_role` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_role_permissions_permission` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='角色-權限關聯表';

-- ==========================================
-- 6. 使用者-權限關聯表 (直接授權)
-- ==========================================
DROP TABLE IF EXISTS `user_permissions`;
CREATE TABLE `user_permissions` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` BIGINT UNSIGNED NOT NULL COMMENT '使用者ID',
  `permission_id` INT UNSIGNED NOT NULL COMMENT '權限ID',
  `is_granted` TINYINT(1) DEFAULT 1 COMMENT '是否授予 (1=授予, 0=撤銷覆蓋角色權限)',
  `granted_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '授權時間',
  `granted_by` BIGINT UNSIGNED DEFAULT NULL COMMENT '授權者ID',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_user_permission` (`user_id`, `permission_id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_permission_id` (`permission_id`),
  CONSTRAINT `fk_user_permissions_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_user_permissions_permission` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='使用者-權限關聯表 (直接授權)';

-- ==========================================
-- 7. 使用者備註表
-- ==========================================
DROP TABLE IF EXISTS `user_notes`;
CREATE TABLE `user_notes` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` BIGINT UNSIGNED NOT NULL COMMENT '使用者ID',
  `note_type` ENUM('finance', 'deliver', 'purchase') NOT NULL COMMENT '備註類型',
  `content` LONGTEXT DEFAULT NULL COMMENT '備註內容',
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_user_note_type` (`user_id`, `note_type`),
  KEY `idx_user_id` (`user_id`),
  CONSTRAINT `fk_user_notes_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='使用者備註表';

-- ==========================================
-- 插入預設角色
-- ==========================================
INSERT INTO `roles` (`name`, `display_name`, `description`, `is_system`) VALUES
('super_admin', '超級管理員', '擁有系統所有權限，可管理一切', 1),
('admin', '管理員', '一般管理員權限', 1),
('finance_manager_tw', '財務主管-台灣', '台灣財務相關完整權限', 0),
('finance_manager_sg', '財務主管-新加坡', '新加坡財務相關完整權限', 0),
('finance_manager_mm', '財務主管-緬甸', '緬甸財務相關完整權限', 0),
('product_manager', '產品主管', '產品管理完整權限', 0),
('purchase_manager', '採購主管', '採購管理完整權限', 0),
('deliver_manager', '出貨主管', '出貨管理完整權限', 0),
('sales_tw', '業務-台灣', '台灣銷售權限', 0),
('sales_sg', '業務-新加坡', '新加坡銷售權限', 0),
('sales_mm', '業務-緬甸', '緬甸銷售權限', 0),
('warehouse_tw', '倉管-台灣', '台灣倉庫管理權限', 0),
('warehouse_sg', '倉管-新加坡', '新加坡倉庫管理權限', 0),
('warehouse_mm', '倉管-緬甸', '緬甸倉庫管理權限', 0),
('member_service', '會員服務', '會員管理相關權限', 0),
('viewer', '訪客', '僅查看權限', 0);

-- ==========================================
-- 插入權限資料 (範例 - 需根據實際需求調整)
-- ==========================================

-- 系統管理
INSERT INTO `permissions` (`name`, `display_name`, `module`, `category`, `action`, `description`) VALUES
('system.manage', '系統管理', 'system', NULL, 'manage', '系統設定管理'),
('user.view', '查看使用者', 'user', NULL, 'view', '查看使用者列表'),
('user.create', '新增使用者', 'user', NULL, 'create', '新增使用者帳號'),
('user.edit', '編輯使用者', 'user', NULL, 'edit', '編輯使用者資料'),
('user.delete', '刪除使用者', 'user', NULL, 'delete', '刪除使用者帳號'),
('user.manage', '管理使用者', 'user', NULL, 'manage', '完整管理使用者');

-- 產品管理
INSERT INTO `permissions` (`name`, `display_name`, `module`, `category`, `action`, `description`) VALUES
('product.view', '查看產品', 'product', NULL, 'view', '查看產品列表和詳情'),
('product.create', '新增產品', 'product', NULL, 'create', '新增產品資料'),
('product.edit', '編輯產品', 'product', NULL, 'edit', '編輯產品資料'),
('product.delete', '刪除產品', 'product', NULL, 'delete', '刪除產品'),
('product.tw.manage', '管理台灣產品', 'product', 'tw', 'manage', '完整管理台灣區產品'),
('product.sg.manage', '管理新加坡產品', 'product', 'sg', 'manage', '完整管理新加坡區產品'),
('product.mm.manage', '管理緬甸產品', 'product', 'mm', 'manage', '完整管理緬甸區產品'),
('product.keyin', '產品輸入', 'product', NULL, 'keyin', '新增產品輸入');

-- 會員管理
INSERT INTO `permissions` (`name`, `display_name`, `module`, `category`, `action`, `description`) VALUES
('member.view', '查看會員', 'member', NULL, 'view', '查看會員資料'),
('member.create', '新增會員', 'member', NULL, 'create', '新增會員'),
('member.edit', '編輯會員', 'member', NULL, 'edit', '編輯會員資料'),
('member.delete', '刪除會員', 'member', NULL, 'delete', '刪除會員'),
('member.tw.manage', '管理台灣會員', 'member', 'tw', 'manage', '完整管理台灣會員'),
('member.sg.manage', '管理新加坡會員', 'member', 'sg', 'manage', '完整管理新加坡會員'),
('member.mm.manage', '管理緬甸會員', 'member', 'mm', 'manage', '完整管理緬甸會員'),
('member.rent.view', '查看租賃會員', 'member', 'rent', 'view', '查看租賃會員資料'),
('member.rent.sg.manage', '管理新加坡租賃會員', 'member', 'rent_sg', 'manage', ''),
('member.rent.mm.manage', '管理緬甸租賃會員', 'member', 'rent_mm', 'manage', '');

-- 財務管理
INSERT INTO `permissions` (`name`, `display_name`, `module`, `category`, `action`, `description`) VALUES
('finance.view', '查看財務', 'finance', NULL, 'view', '查看財務報表'),
('finance.create', '新增財務', 'finance', NULL, 'create', '新增財務記錄'),
('finance.edit', '編輯財務', 'finance', NULL, 'edit', '編輯財務資料'),
('finance.delete', '刪除財務', 'finance', NULL, 'delete', '刪除財務記錄'),
('finance.setting.manage', '財務設定', 'finance', 'setting', 'manage', '財務設定管理');

-- 財務 - 各路線
INSERT INTO `permissions` (`name`, `display_name`, `module`, `category`, `action`, `description`) VALUES
-- 新加坡到台灣
('finance.s2t.view', '查看財務-新加坡到台灣', 'finance', 's2t', 'view', ''),
('finance.s2t.edit', '編輯財務-新加坡到台灣', 'finance', 's2t', 'edit', ''),
('finance.s2t.print', '列印財務-新加坡到台灣', 'finance', 's2t', 'print', ''),
('finance.s2t.print_hint', '列印提示-新加坡到台灣', 'finance', 's2t', 'print_hint', ''),
('finance.s2t.goods_reference', '商品參考-新加坡到台灣', 'finance', 's2t', 'goods_reference', ''),
('finance.s2t.print_goods', '列印商品-新加坡到台灣', 'finance', 's2t', 'print_goods', ''),
-- 新加坡到緬甸
('finance.s2y.view', '查看財務-新加坡到緬甸', 'finance', 's2y', 'view', ''),
('finance.s2y.print_hint', '列印提示-新加坡到緬甸', 'finance', 's2y', 'print_hint', ''),
-- 台灣到新加坡
('finance.t2s.view', '查看財務-台灣到新加坡', 'finance', 't2s', 'view', ''),
('finance.t2s.print_hint', '列印提示-台灣到新加坡', 'finance', 't2s', 'print_hint', ''),
-- 緬甸到新加坡
('finance.y2s.view', '查看財務-緬甸到新加坡', 'finance', 'y2s', 'view', ''),
-- 緬甸到台灣
('finance.y2t.view', '查看財務-緬甸到台灣', 'finance', 'y2t', 'view', ''),
-- 財務轉帳
('finance.trans.tw', '財務轉帳-台灣', 'finance', 'trans_tw', 'manage', ''),
('finance.trans.sg', '財務轉帳-新加坡', 'finance', 'trans_sg', 'manage', ''),
('finance.trans.mm', '財務轉帳-緬甸', 'finance', 'trans_mm', 'manage', '');

-- 採購管理
INSERT INTO `permissions` (`name`, `display_name`, `module`, `category`, `action`, `description`) VALUES
('purchase.view', '查看採購', 'purchase', NULL, 'view', '查看採購記錄'),
('purchase.create', '新增採購', 'purchase', NULL, 'create', '新增採購單'),
('purchase.edit', '編輯採購', 'purchase', NULL, 'edit', '編輯採購資料'),
('purchase.delete', '刪除採購', 'purchase', NULL, 'delete', '刪除採購記錄'),
('purchase.print_hint', '列印採購提示', 'purchase', NULL, 'print_hint', ''),
('purchase.keyin.sg', '採購輸入-新加坡', 'purchase', 'keyin_sg', 'create', ''),
('purchase.keyin.mm', '採購輸入-緬甸', 'purchase', 'keyin_mm', 'create', '');

-- 出貨管理
INSERT INTO `permissions` (`name`, `display_name`, `module`, `category`, `action`, `description`) VALUES
('deliver.view', '查看出貨', 'deliver', NULL, 'view', '查看出貨記錄'),
('deliver.create', '新增出貨', 'deliver', NULL, 'create', '新增出貨單'),
('deliver.edit', '編輯出貨', 'deliver', NULL, 'edit', '編輯出貨資料'),
('deliver.setting.manage', '出貨設定', 'deliver', 'setting', 'manage', '出貨設定管理');

-- 下載管理
INSERT INTO `permissions` (`name`, `display_name`, `module`, `category`, `action`) VALUES
('download.manage', '下載管理', 'download', NULL, 'manage');

-- 給超級管理員所有權限
INSERT INTO `role_permissions` (`role_id`, `permission_id`)
SELECT 1, `id` FROM `permissions`;

-- ==========================================
-- 建立視圖 (View) - 方便查詢
-- ==========================================

-- 使用者完整權限視圖
CREATE OR REPLACE VIEW `v_user_all_permissions` AS
SELECT DISTINCT
  u.id as user_id,
  u.login_id,
  u.name as user_name,
  p.id as permission_id,
  p.name as permission_name,
  p.display_name as permission_display_name,
  p.module,
  p.category,
  p.action,
  CASE 
    WHEN up.id IS NOT NULL THEN 'direct'
    ELSE 'role'
  END as source,
  CASE 
    WHEN up.id IS NOT NULL THEN up.is_granted
    ELSE 1
  END as is_granted
FROM users u
LEFT JOIN user_roles ur ON u.id = ur.user_id
LEFT JOIN role_permissions rp ON ur.role_id = rp.role_id
LEFT JOIN permissions p ON rp.permission_id = p.id
LEFT JOIN user_permissions up ON u.id = up.user_id AND p.id = up.permission_id
WHERE u.status = 'active';

-- 角色權限統計視圖
CREATE OR REPLACE VIEW `v_role_permission_stats` AS
SELECT 
  r.id as role_id,
  r.name as role_name,
  r.display_name as role_display_name,
  COUNT(DISTINCT rp.permission_id) as permission_count,
  COUNT(DISTINCT ur.user_id) as user_count
FROM roles r
LEFT JOIN role_permissions rp ON r.id = rp.role_id
LEFT JOIN user_roles ur ON r.id = ur.role_id
GROUP BY r.id;

SET FOREIGN_KEY_CHECKS = 1;

-- ==========================================
-- 完成
-- ==========================================

