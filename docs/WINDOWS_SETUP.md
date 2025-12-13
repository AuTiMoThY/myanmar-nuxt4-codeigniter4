# Windows 使用者快速設置指南

## 🎯 如果您遇到 `mysql` 不是內部或外部命令的錯誤

別擔心！這是正常的，因為 MySQL 的路徑沒有加入到系統環境變數中。

## ✅ 最簡單的解決方案：使用 phpMyAdmin

### 步驟 1：打開 phpMyAdmin

根據您使用的環境，在瀏覽器中打開：

- **XAMPP**: http://localhost/phpmyadmin
- **WAMP**: http://localhost/phpmyadmin  
- **MAMP**: http://localhost:8888/phpMyAdmin
- **Laragon**: http://localhost/phpmyadmin

### 步驟 2：建立資料庫

1. 點擊左側的「**新增**」或頂部的「**資料庫**」標籤
2. 資料庫名稱輸入：`manthiri`
3. 編碼選擇：`utf8mb4_unicode_ci`
4. 點擊「**建立**」

### 步驟 3：修改使用者認證方式

1. 點擊頂部的「**SQL**」標籤
2. 在 SQL 查詢框中，複製貼上以下指令：

```sql
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '';
FLUSH PRIVILEGES;
```

3. 點擊「**執行**」按鈕（右下角）
4. 如果看到綠色的成功訊息，就完成了！

### 步驟 4：執行資料庫遷移

現在回到您的專案目錄，執行：

```bash
cd D:\auproject\20251001-myanmar\myanmar-nuxt4\api
php spark migrate
```

應該會看到：
```
Running all new migrations...
Done
```

### 步驟 5：建立測試帳號（選填）

```bash
php spark db:seed UserSeeder
```

成功後會顯示：
```
使用者種子資料已成功建立！
管理員帳號 - 帳號: admin, 密碼: password123
一般使用者 - 帳號: user, 密碼: password123
```

### 步驟 6：啟動專案

```bash
# 啟動後端（在 api 目錄下）
php spark serve

# 開新的命令提示字元視窗，啟動前端（在 admin 目錄下）
cd D:\auproject\20251001-myanmar\myanmar-nuxt4\admin
npm run dev
```

### 步驟 7：測試登入

1. 打開瀏覽器訪問：http://localhost:3000/login
2. 使用以下帳號登入：
   - 帳號：`admin`
   - 密碼：`password123`

## 🔧 如果您真的想使用 MySQL 命令列

### XAMPP 使用者：

1. 打開命令提示字元（cmd）
2. 執行：

```bash
cd C:\xampp\mysql\bin
mysql.exe -u root -p
```

按 Enter（因為預設沒有密碼），然後執行 SQL 指令。

### WAMP 使用者：

```bash
cd C:\wamp64\bin\mysql\mysql8.0.x\bin
mysql.exe -u root -p
```

（將 `mysql8.0.x` 替換為您的實際版本）

### Laragon 使用者：

Laragon 通常已經設定好路徑，但如果沒有：

```bash
cd C:\laragon\bin\mysql\mysql-8.x.x-winx64\bin
mysql.exe -u root -p
```

## 📝 檢查 MySQL 是否正在運行

### XAMPP 使用者：
- 打開 XAMPP Control Panel
- 確保 MySQL 旁邊的狀態是綠色的「Running」
- 如果不是，點擊「Start」按鈕

### WAMP 使用者：
- 查看系統托盤中的 WAMP 圖示
- 應該是綠色的
- 如果不是綠色，點擊圖示 → MySQL → Service → Start/Resume Service

### Laragon 使用者：
- 打開 Laragon
- 點擊「Start All」
- 確保 MySQL 顯示為運行中

## ❓ 常見問題

### Q: phpMyAdmin 打不開怎麼辦？

**A:** 確認：
1. Apache 和 MySQL 服務都在運行中
2. 訪問的網址正確
3. 如果使用 XAMPP，確保已啟動 Apache 和 MySQL

### Q: 執行 SQL 後出現錯誤？

**A:** 常見原因：
1. 使用者名稱不是 `root`：將 SQL 中的 `'root'` 改為您的實際使用者名稱
2. 有密碼但沒輸入：將 `BY ''` 改為 `BY 'your_password'`

### Q: 資料庫建立後還是無法連線？

**A:** 檢查 `api/env` 檔案設定：
```ini
database.default.hostname = localhost
database.default.database = manthiri
database.default.username = root
database.default.password = 
database.default.DBDriver = MySQLi
database.default.port = 3306
```

確保這些設定與您的 MySQL 設定一致。

## 🎉 完成！

設置完成後，您就可以：
- 訪問後台管理系統：http://localhost:3000
- 使用 `admin` / `password123` 登入
- 開始開發您的專案！

需要更多協助嗎？請查看：
- [QUICKSTART.md](QUICKSTART.md) - 快速開始指南
- [DATABASE_FIX.md](DATABASE_FIX.md) - 資料庫問題詳細說明
- [SETUP.md](SETUP.md) - 完整設置文件

