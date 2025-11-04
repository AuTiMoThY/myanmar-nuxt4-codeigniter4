-- ==========================================
-- 權限遷移腳本
-- 將舊的 sys_loginsystem 資料遷移到新的 RBAC 系統
-- ==========================================

-- 使用說明：
-- 1. 確保已執行 database_rbac_schema.sql
-- 2. 根據實際情況調整權限映射邏輯
-- 3. 在測試環境先執行並驗證
-- 4. 備份原有資料庫
-- 5. 執行此腳本

SET FOREIGN_KEY_CHECKS = 0;

-- ==========================================
-- 步驟 1: 遷移使用者基本資料
-- ==========================================

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
  sysloginID as id,
  loginID as login_id,
  password,
  name,
  NULL as email, -- 舊系統沒有 email 欄位
  pic,
  profile,
  CASE 
    WHEN expiration_chk = 1 AND expiration_date < CURDATE() THEN 'expired'
    WHEN expiration_chk = 1 THEN 'active'
    ELSE 'active'
  END as status,
  CASE 
    WHEN expiration_date = '0000-00-00' THEN NULL 
    ELSE expiration_date 
  END as expiration_date,
  COALESCE(create_time, NOW()) as created_at,
  COALESCE(update_time, NOW()) as updated_at,
  time as last_login_at
FROM sys_loginsystem
WHERE NOT EXISTS (
  SELECT 1 FROM users WHERE users.id = sys_loginsystem.sysloginID
);

-- ==========================================
-- 步驟 2: 遷移使用者備註
-- ==========================================

-- 財務備註
INSERT INTO user_notes (user_id, note_type, content, updated_at)
SELECT 
  sysloginID,
  'finance',
  note_finance,
  COALESCE(update_time, NOW())
FROM sys_loginsystem
WHERE note_finance IS NOT NULL 
  AND note_finance != ''
  AND NOT EXISTS (
    SELECT 1 FROM user_notes 
    WHERE user_notes.user_id = sys_loginsystem.sysloginID 
      AND user_notes.note_type = 'finance'
  );

-- 出貨備註
INSERT INTO user_notes (user_id, note_type, content, updated_at)
SELECT 
  sysloginID,
  'deliver',
  note_deliver,
  COALESCE(update_time, NOW())
FROM sys_loginsystem
WHERE note_deliver IS NOT NULL 
  AND note_deliver != ''
  AND NOT EXISTS (
    SELECT 1 FROM user_notes 
    WHERE user_notes.user_id = sys_loginsystem.sysloginID 
      AND user_notes.note_type = 'deliver'
  );

-- 採購備註
INSERT INTO user_notes (user_id, note_type, content, updated_at)
SELECT 
  sysloginID,
  'purchase',
  note_purchase,
  COALESCE(update_time, NOW())
FROM sys_loginsystem
WHERE note_purchase IS NOT NULL 
  AND note_purchase != ''
  AND NOT EXISTS (
    SELECT 1 FROM user_notes 
    WHERE user_notes.user_id = sys_loginsystem.sysloginID 
      AND user_notes.note_type = 'purchase'
  );

-- ==========================================
-- 步驟 3: 建立權限映射臨時表
-- ==========================================

DROP TEMPORARY TABLE IF EXISTS temp_power_mapping;
CREATE TEMPORARY TABLE temp_power_mapping (
  power_field VARCHAR(100),
  permission_name VARCHAR(100),
  min_value INT DEFAULT 1 -- power_* 欄位需要達到的最小值
);

-- 插入權限映射關係
INSERT INTO temp_power_mapping (power_field, permission_name, min_value) VALUES
-- 產品管理
('power_product', 'product.view', 1),
('power_product', 'product.create', 4),
('power_product', 'product.edit', 2),
('power_product_sg', 'product.sg.manage', 1),
('power_product_mm', 'product.mm.manage', 1),
('power_new_product_keyin', 'product.keyin', 1),

-- 會員管理
('power_member', 'member.view', 1),
('power_member', 'member.create', 4),
('power_member', 'member.edit', 2),
('power_member_singapore', 'member.sg.manage', 1),
('power_member_myanmar', 'member.mm.manage', 1),
('power_memberRent', 'member.rent.view', 1),
('power_memberRent_singapore', 'member.rent.sg.manage', 1),
('power_memberRent_myanmar', 'member.rent.mm.manage', 1),

-- 財務管理
('power_finance', 'finance.view', 1),
('power_finance', 'finance.edit', 2),
('power_finance_s2t', 'finance.s2t.view', 1),
('power_finance_s2y', 'finance.s2y.view', 1),
('power_finance_t2s', 'finance.t2s.view', 1),
('power_finance_y2s', 'finance.y2s.view', 1),
('power_finance_y2t', 'finance.y2t.view', 1),
('power_finance_s2t_print_hint', 'finance.s2t.print_hint', 1),
('power_finance_s2y_print_hint', 'finance.s2y.print_hint', 1),
('power_finance_t2s_print_hint', 'finance.t2s.print_hint', 1),
('power_finance_s2t_goods_reference', 'finance.s2t.goods_reference', 1),
('power_finance_s2t_print_goods', 'finance.s2t.print_goods', 1),
('power_finance_setting', 'finance.setting.manage', 1),
('power_finance_trans_tw', 'finance.trans.tw', 1),
('power_finance_trans_sg', 'finance.trans.sg', 1),
('power_finance_trans_mm', 'finance.trans.mm', 1),

-- 預付財務
('power_pre_finance', 'pre_finance.view', 1),
('power_pre_finance_s2t', 'pre_finance.s2t.view', 1),
('power_pre_finance_s2t_approve', 'pre_finance.s2t.approve', 1),
('power_pre_finance_s2t_print', 'pre_finance.s2t.print', 1),
('power_pre_finance_from_tw', 'pre_finance.from_tw', 1),
('power_pre_finance_to_tw', 'pre_finance.to_tw', 1),

-- 出貨管理
('power_deliver', 'deliver.view', 1),
('power_new_deliver', 'deliver.create', 1),
('power_deliverb2t', 'deliver.b2t.view', 1),
('power_deliver_b2t', 'deliver.b2t.view', 1),
('power_deliver_t2b', 'deliver.t2b.view', 1),
('power_new_deliver_s2t', 'deliver.new.s2t', 1),
('power_deliver_setting', 'deliver.setting.manage', 1),

-- 採購管理
('power_purchase', 'purchase.view', 1),
('power_purchase', 'purchase.create', 2),
('power_purchaseb2s', 'purchase.b2s.view', 1),
('power_purchaseb2t', 'purchase.b2t.view', 1),
('power_purchases2b', 'purchase.s2b.view', 1),
('power_purchases2t', 'purchase.s2t.view', 1),
('power_purchaset2s', 'purchase.t2s.view', 1),
('power_purchase_print_hint', 'purchase.print_hint', 1),
('power_new_purchase_keyin_sg', 'purchase.keyin.sg', 1),
('power_new_purchase_keyin_mm', 'purchase.keyin.mm', 1),

-- 下載管理
('power_download', 'download.manage', 1),

-- 系統管理
('power_system', 'system.manage', 1),
('power_login', 'user.manage', 1),

-- 進出貨
('power_in_out', 'in_out.view', 1),
('power_in_out_singapore', 'in_out.sg.manage', 1),
('power_in_out_myanmar', 'in_out.mm.manage', 1),

-- 設定管理
('power_exchange_setting', 'exchange.setting.manage', 1),
('power_income_text_setting', 'income_text.setting.manage', 1),
('power_feedback_setting', 'feedback.setting.manage', 1),

-- 購物管理
('power_shopping', 'shopping.manage', 1),
('power_mm_shopping', 'shopping.mm.manage', 1),

-- POS 系統
('power_pos_sale_report', 'pos.sale.report', 1),
('power_pos_sale_report_sg', 'pos.sale.report.sg', 1),
('power_pos_sale_report_mm', 'pos.sale.report.mm', 1),
('power_pos_expense', 'pos.expense', 1),
('power_pos_expense_sg', 'pos.expense.sg', 1),
('power_pos_expense_mm', 'pos.expense.mm', 1),
('power_pos_member', 'pos.member.manage', 1),
('power_pos_marquee', 'pos.marquee', 1),
('power_pos_marquee_sg', 'pos.marquee.sg', 1),
('power_pos_marquee_mm', 'pos.marquee.mm', 1),
('power_pos_cus_marquee', 'pos.cus_marquee', 1),
('power_pos_store_income', 'pos.store_income', 1),
('power_pos_store_income_pim_in', 'pos.store_income.pim_in', 1),
('power_pos_store_income_pim_out', 'pos.store_income.pim_out', 1),
('power_pos_sale_system', 'pos.sale.system', 1),
('power_pos_sale_system_sg', 'pos.sale.system.sg', 1),
('power_pos_sale_system_mm', 'pos.sale.system.mm', 1),
('power_pos_rtn_system', 'pos.rtn.system', 1),

-- 人事管理
('power_staff', 'staff.view', 1),
('power_staff_modify', 'staff.modify', 1),
('power_staff_salary_input', 'staff.salary.input', 1),
('power_staff_print', 'staff.print', 1),

-- POE 系統
('power_poe', 'poe.manage', 1),
('power_poe_country', 'poe.country', 1),
('power_poe_exchange', 'poe.exchange', 1),
('power_poe_bill_setting', 'poe.bill.setting', 1),
('power_poe_stock_report', 'poe.stock.report', 1),
('power_poe_chat', 'poe.chat', 1),
('power_poe_print', 'poe.print', 1),
('power_poe_admin', 'poe.admin', 1),

-- KTV 系統
('power_ktv', 'ktv.manage', 1),
('power_ktv_sg', 'ktv.sg.manage', 1),
('power_ktv_mm', 'ktv.mm.manage', 1),

-- 計算機
('power_cal_tw', 'cal.tw', 1),
('power_cal_sg', 'cal.sg', 1),
('power_cal_mm', 'cal.mm', 1),

-- 輪播圖
('power_slide_show_tw', 'slide_show.tw', 1),
('power_slide_show_sg', 'slide_show.sg', 1),
('power_slide_show_mm', 'slide_show.mm', 1);

-- ==========================================
-- 步驟 4: 執行權限遷移
-- ==========================================

-- 建立臨時儲存過程
DELIMITER $$

DROP PROCEDURE IF EXISTS migrate_user_permissions_batch$$
CREATE PROCEDURE migrate_user_permissions_batch()
BEGIN
  DECLARE done INT DEFAULT FALSE;
  DECLARE v_user_id BIGINT;
  
  -- 宣告游標
  DECLARE user_cursor CURSOR FOR 
    SELECT sysloginID FROM sys_loginsystem;
  
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

  -- 開啟游標
  OPEN user_cursor;

  read_loop: LOOP
    FETCH user_cursor INTO v_user_id;
    
    IF done THEN
      LEAVE read_loop;
    END IF;

    -- 對每個使用者進行權限遷移
    INSERT IGNORE INTO user_permissions (user_id, permission_id, is_granted, granted_at, granted_by)
    SELECT 
      v_user_id,
      p.id,
      1,
      NOW(),
      NULL
    FROM temp_power_mapping m
    JOIN permissions p ON p.name = m.permission_name
    WHERE EXISTS (
      SELECT 1 
      FROM sys_loginsystem s 
      WHERE s.sysloginID = v_user_id
      AND (
        -- 使用動態方式檢查欄位值
        CASE m.power_field
          WHEN 'power_product' THEN s.power_product
          WHEN 'power_product_sg' THEN s.power_product_sg
          WHEN 'power_product_mm' THEN s.power_product_mm
          WHEN 'power_member' THEN s.power_member
          WHEN 'power_member_singapore' THEN s.power_member_singapore
          WHEN 'power_member_myanmar' THEN s.power_member_myanmar
          WHEN 'power_finance' THEN s.power_finance
          WHEN 'power_finance_s2t' THEN s.power_finance_s2t
          WHEN 'power_system' THEN s.power_system
          WHEN 'power_login' THEN s.power_login
          -- 可根據需要繼續添加...
          ELSE 0
        END
      ) >= m.min_value
    );

  END LOOP;

  CLOSE user_cursor;
END$$

DELIMITER ;

-- 執行遷移（這可能需要一些時間）
CALL migrate_user_permissions_batch();

-- 清理臨時程序
DROP PROCEDURE IF EXISTS migrate_user_permissions_batch;

-- ==========================================
-- 步驟 5: 特殊使用者處理
-- ==========================================

-- 將特定使用者設為超級管理員 (根據實際情況調整)
-- 範例：將 loginID = 'jeffery' 的使用者設為超級管理員
INSERT IGNORE INTO user_roles (user_id, role_id, granted_at)
SELECT 
  u.id,
  (SELECT id FROM roles WHERE name = 'super_admin'),
  NOW()
FROM users u
WHERE u.login_id = 'jeffery';

-- ==========================================
-- 步驟 6: 驗證遷移結果
-- ==========================================

-- 檢查遷移的使用者數量
SELECT 
  '使用者遷移統計' as title,
  COUNT(*) as total_users,
  SUM(CASE WHEN status = 'active' THEN 1 ELSE 0 END) as active_users,
  SUM(CASE WHEN status = 'inactive' THEN 1 ELSE 0 END) as inactive_users,
  SUM(CASE WHEN status = 'expired' THEN 1 ELSE 0 END) as expired_users
FROM users;

-- 檢查權限分配統計
SELECT 
  '權限分配統計' as title,
  COUNT(DISTINCT user_id) as users_with_permissions,
  COUNT(*) as total_permission_grants,
  AVG(perms_per_user) as avg_permissions_per_user
FROM (
  SELECT user_id, COUNT(*) as perms_per_user
  FROM user_permissions
  GROUP BY user_id
) as stats;

-- 檢查備註遷移
SELECT 
  '備註遷移統計' as title,
  SUM(CASE WHEN note_type = 'finance' THEN 1 ELSE 0 END) as finance_notes,
  SUM(CASE WHEN note_type = 'deliver' THEN 1 ELSE 0 END) as deliver_notes,
  SUM(CASE WHEN note_type = 'purchase' THEN 1 ELSE 0 END) as purchase_notes
FROM user_notes;

-- 列出前 10 個使用者的權限
SELECT 
  u.id,
  u.login_id,
  u.name,
  COUNT(DISTINCT up.permission_id) as direct_permissions,
  COUNT(DISTINCT ur.role_id) as roles
FROM users u
LEFT JOIN user_permissions up ON u.id = up.user_id
LEFT JOIN user_roles ur ON u.id = ur.user_id
GROUP BY u.id
ORDER BY u.id
LIMIT 10;

SET FOREIGN_KEY_CHECKS = 1;

-- ==========================================
-- 遷移完成
-- ==========================================

SELECT '========================================' as message
UNION ALL
SELECT '權限系統遷移完成！'
UNION ALL
SELECT '請檢查上方的統計資料'
UNION ALL
SELECT '並在應用程式中進行功能測試'
UNION ALL
SELECT '========================================';

