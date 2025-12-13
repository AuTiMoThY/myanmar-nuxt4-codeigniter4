# 緬甸文亂碼修正指南

## 問題說明

SQL 檔案中的緬甸文字符出現了亂碼，例如：
- 原始應該是：`ygnခင်ခင်မိုး`
- 顯示為：`ygná€á€­á€¯á€„á€¹á€á€­á€¯á€„á€¹á€'á€¼á€"á€¹á€¸`

這是典型的**雙重編碼問題**：
1. 原始 UTF-8 編碼的緬甸文字節序列
2. 被錯誤地以 Latin1/ISO-8859-1 讀取
3. 然後再以 UTF-8 儲存

## 解決方案

### 方法 1：使用 MySQL 的 CONVERT 函數（推薦）

在 MySQL 中執行以下 SQL 來修正編碼：

```sql
-- 備份原始資料
CREATE TABLE sys_loginsystem_backup AS SELECT * FROM sys_loginsystem;

-- 修正 name 欄位的編碼
UPDATE sys_loginsystem 
SET name = CONVERT(
    CAST(CONVERT(name USING latin1) AS BINARY) 
    USING utf8mb4
)
WHERE name LIKE '%á€%';

-- 修正 profile 欄位的編碼（如果有）
UPDATE sys_loginsystem 
SET profile = CONVERT(
    CAST(CONVERT(profile USING latin1) AS BINARY) 
    USING utf8mb4
)
WHERE profile LIKE '%á€%';
```

### 方法 2：使用 Python 腳本修正 SQL 檔案

我已經創建了修正腳本，但由於編碼問題的複雜性，建議使用以下方法：

1. **直接從資料庫匯出正確的資料**：
   - 確保資料庫連線使用 UTF-8 編碼
   - 使用 `mysqldump` 匯出：
     ```bash
     mysqldump -u root -p --default-character-set=utf8mb4 manthiri sys_loginsystem > sys_loginsystem_fixed.sql
     ```

2. **或者在應用程式中修正**：
   - 在讀取資料時進行編碼轉換
   - 確保資料庫連線使用正確的字符集

### 方法 3：手動修正（適用於少量資料）

如果只有少量資料需要修正，可以：

1. 在資料庫中直接更新：
   ```sql
   UPDATE sys_loginsystem 
   SET name = '正確的緬甸文' 
   WHERE loginID = 'ygnkkt030';
   ```

2. 或者使用 phpMyAdmin 等工具手動編輯

## 預防措施

1. **確保資料庫字符集正確**：
   ```sql
   ALTER DATABASE manthiri CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
   ALTER TABLE sys_loginsystem CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
   ```

2. **確保應用程式連線使用 UTF-8**：
   - CodeIgniter 配置已設定為 `utf8mb4`
   - 確保 PHP 檔案本身也是 UTF-8 編碼

3. **匯出 SQL 時使用正確的字符集**：
   ```bash
   mysqldump --default-character-set=utf8mb4 ...
   ```

## 注意事項

- 修正前請務必備份資料
- 建議先在測試環境中驗證修正方法
- 如果資料量很大，建議分批處理

