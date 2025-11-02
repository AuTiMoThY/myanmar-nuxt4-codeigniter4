# 快速開始指南

## 後端設置（CodeIgniter4）

1. **安裝依賴**
   ```bash
   cd api
   composer install
   ```

2. **配置資料庫**
   - 編輯 `api/env` 檔案
   - 設定資料庫連線資訊
   - **重要：** 如果使用 MySQL 8.0+，可能需要先修改使用者認證方式（見下方說明）

3. **建立資料庫**
   ```sql
   CREATE DATABASE IF NOT EXISTS manthiri CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
   ```

4. **執行遷移**
   ```bash
   php spark migrate
   ```
   
   **如果遇到錯誤 `Plugin 'mysql_native_password' is not loaded`：**
   
   請在 MySQL 中執行以下指令（將密碼替換為您的密碼，若無密碼則留空 `''`）：
   ```sql
   ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '';
   FLUSH PRIVILEGES;
   ```
   
   詳細解決方案請參閱 [DATABASE_FIX.md](DATABASE_FIX.md)

5. **建立測試帳號（選填）**
   ```bash
   php spark db:seed UserSeeder
   ```
   這會建立：
   - 管理員：帳號 `admin` / 密碼 `password123`
   - 一般使用者：帳號 `user` / 密碼 `password123`

6. **啟動伺服器**
   ```bash
   php spark serve
   ```
   API 將在 http://localhost:8080 運行

## 前端設置（Nuxt4）

1. **安裝依賴**
   ```bash
   cd admin
   npm install
   ```

2. **啟動開發伺服器**
   ```bash
   npm run dev
   ```
   應用程式將在 http://localhost:3000 運行

## 測試登入

1. 打開瀏覽器訪問 http://localhost:3000/login
2. 使用以下帳號登入：
   - 帳號：`admin`
   - 密碼：`password123`

## 主要檔案說明

### 後端（CodeIgniter4）
- `api/app/Database/Migrations/` - 資料庫遷移檔案
- `api/app/Models/UserModel.php` - 使用者模型
- `api/app/Controllers/AuthController.php` - 認證控制器
- `api/app/Helpers/jwt_helper.php` - JWT 輔助函式
- `api/app/Config/Cors.php` - CORS 配置
- `api/app/Config/Routes.php` - 路由配置

### 前端（Nuxt4）
- `admin/app/composables/useAuth.ts` - 認證 Composable
- `admin/app/middleware/auth.ts` - 認證中介層
- `admin/app/pages/login.vue` - 登入頁面
- `admin/app/components/UserMenu.vue` - 使用者選單（含登出功能）

## 使用者資料表結構

| 欄位 | 類型 | 說明 |
|------|------|------|
| id | INT | 主鍵 |
| username | VARCHAR(100) | 使用者名稱（唯一） |
| email | VARCHAR(255) | 電子郵件（唯一） |
| password | VARCHAR(255) | 加密密碼 |
| full_name | VARCHAR(255) | 全名 |
| role | ENUM | 角色（admin/user/manager） |
| status | ENUM | 狀態（active/inactive/suspended） |
| avatar | VARCHAR(255) | 頭像 URL |
| last_login | DATETIME | 最後登入時間 |
| created_at | DATETIME | 建立時間 |
| updated_at | DATETIME | 更新時間 |
| deleted_at | DATETIME | 刪除時間（軟刪除） |

## 需要注意的安全設定

⚠️ **重要：在生產環境部署前，請務必：**

1. 在 `api/env` 中設定強隨機的 `JWT_SECRET_KEY`
2. 更改預設管理員密碼
3. 啟用 HTTPS
4. 檢查 CORS 設定，只允許信任的來源

詳細說明請參閱 [SETUP.md](SETUP.md)

