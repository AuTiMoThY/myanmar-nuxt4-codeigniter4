-- 修正緬甸文亂碼的 SQL 腳本
-- 使用前請先備份資料庫！

-- 步驟 1: 備份原始資料表
CREATE TABLE IF NOT EXISTS sys_loginsystem_backup AS 
SELECT * FROM sys_loginsystem;

-- 步驟 2: 修正 name 欄位的編碼
-- 這個方法將雙重編碼的 UTF-8 還原為正確的 UTF-8
UPDATE sys_loginsystem 
SET name = CONVERT(
    CAST(CONVERT(name USING latin1) AS BINARY) 
    USING utf8mb4
)
WHERE name LIKE '%á€%' 
   OR name LIKE '%á%' 
   OR name REGEXP '[á€]';

-- 步驟 3: 修正 profile 欄位的編碼（如果有亂碼）
UPDATE sys_loginsystem 
SET profile = CONVERT(
    CAST(CONVERT(profile USING latin1) AS BINARY) 
    USING utf8mb4
)
WHERE profile LIKE '%á€%' 
   OR profile LIKE '%á%' 
   OR profile REGEXP '[á€]';

-- 步驟 4: 修正 note_finance 欄位的編碼（繁體中文亂碼）
UPDATE sys_loginsystem 
SET note_finance = CONVERT(
    CAST(CONVERT(note_finance USING latin1) AS BINARY) 
    USING utf8mb4
)
WHERE (note_finance LIKE '%å%' 
   OR note_finance LIKE '%æ%'
   OR note_finance REGEXP '[åæ]')
   AND note_finance IS NOT NULL;

-- 步驟 5: 修正 note_deliver 欄位的編碼（繁體中文亂碼）
UPDATE sys_loginsystem 
SET note_deliver = CONVERT(
    CAST(CONVERT(note_deliver USING latin1) AS BINARY) 
    USING utf8mb4
)
WHERE (note_deliver LIKE '%å%' 
   OR note_deliver LIKE '%æ%'
   OR note_deliver REGEXP '[åæ]')
   AND note_deliver IS NOT NULL;

-- 步驟 6: 修正 note_purchase 欄位的編碼（繁體中文亂碼）
UPDATE sys_loginsystem 
SET note_purchase = CONVERT(
    CAST(CONVERT(note_purchase USING latin1) AS BINARY) 
    USING utf8mb4
)
WHERE (note_purchase LIKE '%å%' 
   OR note_purchase LIKE '%æ%'
   OR note_purchase REGEXP '[åæ]')
   AND note_purchase IS NOT NULL;

-- 步驟 7: 驗證修正結果
-- 檢查 name 欄位是否還有亂碼
SELECT sysloginID, loginID, name 
FROM sys_loginsystem 
WHERE name LIKE '%á€%' 
   OR name REGEXP '[á€]';

-- 檢查 note_finance 欄位是否還有亂碼
SELECT sysloginID, loginID, LEFT(note_finance, 50) AS note_finance_preview
FROM sys_loginsystem 
WHERE note_finance LIKE '%å%' 
   OR note_finance LIKE '%æ%'
   OR note_finance REGEXP '[åæ]';

-- 如果還有亂碼，可能需要手動修正或使用其他方法

-- 步驟 8: 匯出修正後的資料（可選）
-- 使用 mysqldump 匯出：
-- mysqldump -u root -p --default-character-set=utf8mb4 manthiri sys_loginsystem > sys_loginsystem_fixed.sql

