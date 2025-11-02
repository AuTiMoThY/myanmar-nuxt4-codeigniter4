# MySQL 8.4+ 認證問題修復

## 問題說明

如果您遇到以下錯誤：
```
#1524 - Plugin 'mysql_native_password' is not loaded
```

這表示您使用的是 MySQL 8.4 或更新版本。從 MySQL 8.4 開始，`mysql_native_password` 插件已被移除，只能使用 `caching_sha2_password`。

## 解決方案

### 步驟 1：在 phpMyAdmin 中執行（建立資料庫）

```sql
-- 建立資料庫
CREATE DATABASE IF NOT EXISTS manthiri CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- 使用 caching_sha2_password（MySQL 8.4+ 預設）
ALTER USER 'root'@'localhost' IDENTIFIED WITH caching_sha2_password BY '';

-- 刷新權限
FLUSH PRIVILEGES;
```

### 步驟 2：修改 CodeIgniter4 資料庫配置

編輯檔案 `api/app/Config/Database.php`，找到第 40 行左右的 `'encrypt'` 設定。

**原始設定：**
```php
public array $default = [
    'DSN'          => '',
    'hostname'     => 'localhost',
    'username'     => '',
    'password'     => '',
    'database'     => '',
    'DBDriver'     => 'MySQLi',
    'DBPrefix'     => '',
    'pConnect'     => false,
    'DBDebug'      => true,
    'charset'      => 'utf8mb4',
    'DBCollat'     => 'utf8mb4_general_ci',
    'swapPre'      => '',
    'encrypt'      => false,  // ← 這裡
    'compress'     => false,
    'strictOn'     => false,
    'failover'     => [],
    'port'         => 3306,
    'numberNative' => false,
    'foundRows'    => false,
    'dateFormat'   => [
        'date'     => 'Y-m-d',
        'datetime' => 'Y-m-d H:i:s',
        'time'     => 'H:i:s',
    ],
];
```

**修改為：**
```php
public array $default = [
    'DSN'          => '',
    'hostname'     => 'localhost',
    'username'     => '',
    'password'     => '',
    'database'     => '',
    'DBDriver'     => 'MySQLi',
    'DBPrefix'     => '',
    'pConnect'     => false,
    'DBDebug'      => true,
    'charset'      => 'utf8mb4',
    'DBCollat'     => 'utf8mb4_general_ci',
    'swapPre'      => '',
    'encrypt'      => ['ssl_verify' => false],  // ← 改這裡
    'compress'     => false,
    'strictOn'     => false,
    'failover'     => [],
    'port'         => 3306,
    'numberNative' => false,
    'foundRows'    => false,
    'dateFormat'   => [
        'date'     => 'Y-m-d',
        'datetime' => 'Y-m-d H:i:s',
        'time'     => 'H:i:s',
    ],
];
```

**只需要改一行：**
```php
// 從這個
'encrypt' => false,

// 改成這個
'encrypt' => ['ssl_verify' => false],
```

### 步驟 3：執行資料庫遷移

```bash
cd D:\auproject\20251001-myanmar\myanmar-nuxt4\api
php spark migrate
```

應該會成功顯示：
```
Running all new migrations...
Done
```

## 為什麼需要這樣設定？

- MySQL 8.4+ 使用 `caching_sha2_password` 作為預設認證方式
- 這種認證方式需要 SSL 連線或 RSA 公鑰交換
- 在本地開發環境中，我們使用 `ssl_verify => false` 來允許不驗證 SSL 憑證的連線
- 這對本地開發是安全的，但**在生產環境中應該使用正確的 SSL 憑證**

## 生產環境建議

在生產環境中，建議：

1. **使用正確的 SSL 憑證：**
```php
'encrypt' => [
    'ssl_key'    => '/path/to/client-key.pem',
    'ssl_cert'   => '/path/to/client-cert.pem',
    'ssl_ca'     => '/path/to/ca-cert.pem',
    'ssl_verify' => true,
],
```

2. **或建立專用的資料庫使用者：**
```sql
CREATE USER 'ci4app'@'localhost' IDENTIFIED WITH caching_sha2_password BY 'strong_password_here';
GRANT ALL PRIVILEGES ON manthiri.* TO 'ci4app'@'localhost';
FLUSH PRIVILEGES;
```

然後在 `api/env` 中：
```ini
database.default.username = ci4app
database.default.password = strong_password_here
```

## 替代方案：降級到 MySQL 8.0

如果以上方案都不適用，您可以考慮降級到 MySQL 8.0 - 8.3 版本，這些版本仍然支援 `mysql_native_password`。

但通常不建議降級，因為新版本有更好的安全性和效能。

## 驗證連線

設定完成後，可以使用以下指令測試連線：

```bash
php spark db:table users
```

如果成功，會顯示 users 資料表的結構。

