# 資料庫連線錯誤修復指南

## 錯誤訊息
```
Plugin 'mysql_native_password' is not loaded
```

## 原因
MySQL 8.0+ 預設使用 `caching_sha2_password` 認證方式，但某些配置下可能會遇到相容性問題。

## 解決方案

### 方案 1：修改 MySQL 使用者認證方式（推薦）

#### 方法 A：使用 phpMyAdmin（最簡單，推薦 Windows 使用者）：

1. 打開瀏覽器，訪問 phpMyAdmin：
   - XAMPP: http://localhost/phpmyadmin
   - WAMP: http://localhost/phpmyadmin
   - MAMP: http://localhost:8888/phpMyAdmin

2. 登入後，點擊頂部的「**SQL**」標籤

3. 在 SQL 查詢框中，貼上以下指令並點擊「**執行**」：

```sql
-- 如果 root 沒有密碼（XAMPP/WAMP 預設通常無密碼）
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '';

-- 刷新權限
FLUSH PRIVILEGES;
```

4. 如果成功，會顯示綠色的成功訊息

5. 同樣在 phpMyAdmin 中建立資料庫（如果還沒建立）：

```sql
CREATE DATABASE IF NOT EXISTS manthiri CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
```

#### 方法 B：使用 MySQL 命令列（需要找到 MySQL 路徑）：

**Windows 使用者：** 如果您使用 XAMPP、WAMP 或獨立安裝的 MySQL，請使用完整路徑：

##### XAMPP 使用者：
```bash
# 進入 XAMPP 的 MySQL bin 目錄
cd C:\xampp\mysql\bin

# 連線到 MySQL（如果沒有密碼，直接按 Enter）
mysql.exe -u root -p

# 執行以下 SQL 指令
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '';
FLUSH PRIVILEGES;
EXIT;
```

##### WAMP 使用者：
```bash
# 進入 WAMP 的 MySQL bin 目錄（版本號可能不同）
cd C:\wamp64\bin\mysql\mysql8.0.x\bin

# 連線到 MySQL
mysql.exe -u root -p

# 執行 SQL 指令
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '';
FLUSH PRIVILEGES;
EXIT;
```

##### 獨立安裝的 MySQL：
```bash
# 通常在以下位置
cd "C:\Program Files\MySQL\MySQL Server 8.0\bin"

# 連線到 MySQL
mysql.exe -u root -p

# 執行 SQL 指令
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '';
FLUSH PRIVILEGES;
EXIT;
```

### 方案 2：建立新的資料庫使用者

如果您不想修改 root 使用者，可以建立一個專門的使用者：

```sql
-- 建立新使用者（使用 mysql_native_password）
CREATE USER 'ci4user'@'localhost' IDENTIFIED WITH mysql_native_password BY 'your_password';

-- 授予權限給 manthiri 資料庫
GRANT ALL PRIVILEGES ON manthiri.* TO 'ci4user'@'localhost';

-- 刷新權限
FLUSH PRIVILEGES;
```

然後修改 `api/env` 檔案：
```ini
database.default.username = ci4user
database.default.password = your_password
```

### 方案 3：修改 MySQL 預設認證插件（全域設定）

編輯 MySQL 設定檔（`my.cnf` 或 `my.ini`）：

1. 找到設定檔位置：
   - Windows: `C:\ProgramData\MySQL\MySQL Server 8.x\my.ini`
   - Linux: `/etc/mysql/my.cnf` 或 `/etc/my.cnf`
   - macOS: `/usr/local/etc/my.cnf`

2. 在 `[mysqld]` 區段添加：
```ini
[mysqld]
default_authentication_plugin=mysql_native_password
```

3. 重啟 MySQL 服務：
   - Windows: `net stop MySQL80` 然後 `net start MySQL80`
   - Linux: `sudo service mysql restart`
   - macOS: `brew services restart mysql`

### 方案 4：檢查資料庫是否存在

確保資料庫 `manthiri` 已經建立：

```sql
CREATE DATABASE IF NOT EXISTS manthiri CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
```

## 執行遷移

問題解決後，重新執行遷移：

```bash
cd api
php spark migrate
```

如果成功，您應該會看到：
```
Running all new migrations...
Done
```

## 建立測試帳號（選填）

遷移成功後，可以建立測試帳號：

```bash
php spark db:seed UserSeeder
```

這會建立兩個測試帳號：
- 管理員：`admin` / `password123`
- 一般使用者：`user` / `password123`

## 驗證資料庫連線

您可以使用以下指令測試資料庫連線：

```bash
php spark db:table users
```

如果連線成功，會顯示 users 資料表的結構。

## 常見問題

### Q: 我不知道 MySQL root 密碼怎麼辦？

A: 如果您使用 XAMPP、WAMP 或 MAMP，預設 root 密碼通常是空的。如果忘記密碼，需要重置 MySQL root 密碼。

### Q: 我使用的是 MariaDB，也會有這個問題嗎？

A: MariaDB 通常不會有這個問題，但如果遇到，同樣的解決方案也適用。

### Q: 修改後還是無法連線？

A: 請檢查：
1. MySQL 服務是否正在運行
2. `env` 檔案中的資料庫名稱、使用者名稱、密碼是否正確
3. 資料庫 `manthiri` 是否已經建立
4. 防火牆是否阻擋了 3306 端口

## 需要協助？

如果以上方案都無法解決問題，請提供：
1. MySQL 版本（執行 `mysql --version`）
2. PHP 版本（執行 `php -v`）
3. 完整的錯誤訊息

