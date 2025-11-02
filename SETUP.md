# 登入系統設置指南

本專案包含一個完整的登入系統，使用 Nuxt4 作為前端和 CodeIgniter4 作為後端 API。

## 後端設置 (CodeIgniter4)

### 1. 安裝依賴套件

```bash
cd api
composer install
```

這將安裝所需的 `firebase/php-jwt` 套件以處理 JWT 認證。

### 2. 配置環境變數

複製 `.env.example` 到 `env` 或 `.env`：

```bash
cp .env.example env
```

編輯 `env` 檔案，設定您的資料庫連線資訊和 JWT 金鑰：

```ini
database.default.hostname = localhost
database.default.database = manthiri
database.default.username = root
database.default.password = 
database.default.DBDriver = MySQLi
database.default.port = 3306

JWT_SECRET_KEY = your-secret-key-change-in-production
```

**重要：** 請務必將 `JWT_SECRET_KEY` 更改為一個強隨機字串，在生產環境中尤其重要。

### 3. 執行資料庫遷移

```bash
cd api
php spark migrate
```

這將建立 `users` 資料表，包含以下欄位：

- `id` - 主鍵
- `username` - 使用者名稱（唯一）
- `email` - 電子郵件（唯一）
- `password` - 密碼（加密儲存）
- `full_name` - 全名
- `role` - 角色（admin, user, manager）
- `status` - 狀態（active, inactive, suspended）
- `avatar` - 頭像 URL
- `last_login` - 最後登入時間
- `created_at` - 建立時間
- `updated_at` - 更新時間
- `deleted_at` - 刪除時間（軟刪除）

### 4. 啟動後端伺服器

```bash
cd api
php spark serve
```

預設會在 `http://localhost:8080` 啟動。

### 5. API 端點

後端提供以下 API 端點：

- `POST /api/auth/login` - 使用者登入
- `POST /api/auth/register` - 註冊新使用者
- `POST /api/auth/logout` - 登出
- `GET /api/auth/me` - 取得當前使用者資訊（需要認證）

## 前端設置 (Nuxt4)

### 1. 安裝依賴套件

```bash
cd admin
npm install
```

### 2. 配置環境變數

建立 `.env` 檔案：

```bash
cp .env.example .env
```

編輯 `.env` 檔案，設定 API 基礎 URL：

```ini
NUXT_PUBLIC_API_BASE=http://localhost:8080/api
```

### 3. 啟動開發伺服器

```bash
cd admin
npm run dev
```

預設會在 `http://localhost:3000` 啟動。

## 使用方式

### 建立第一個管理員帳號

您可以透過以下方式建立第一個管理員帳號：

#### 方法 1: 使用註冊功能（前端）

1. 訪問 `http://localhost:3000/login`
2. 點擊「立即註冊」
3. 填寫註冊資訊並送出
4. 註冊後需要手動在資料庫中將該使用者的 `role` 更改為 `admin`

#### 方法 2: 直接插入資料庫

執行以下 SQL（密碼為 `password123`）：

```sql
INSERT INTO `users` (
    `username`, 
    `email`, 
    `password`, 
    `full_name`, 
    `role`, 
    `status`, 
    `created_at`
) VALUES (
    'admin',
    'admin@example.com',
    '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi',
    'Administrator',
    'admin',
    'active',
    NOW()
);
```

### 登入系統

1. 訪問 `http://localhost:3000/login`
2. 輸入使用者名稱（或電子郵件）和密碼
3. 點擊「登入」
4. 成功後將導向首頁

### 頁面保護

所有需要認證的頁面都應該在 `definePageMeta` 中加入 `auth` middleware：

```vue
<script setup lang="ts">
definePageMeta({
    middleware: ['auth']
})
</script>
```

這將確保未登入的使用者無法訪問該頁面，會自動導向登入頁。

## 架構說明

### 後端 (CodeIgniter4)

- **Migration**: `api/app/Database/Migrations/2025-11-02-000001_CreateUsersTable.php`
  - 定義使用者資料表結構
  
- **Model**: `api/app/Models/UserModel.php`
  - 處理使用者資料的 CRUD 操作
  - 自動加密密碼
  - 提供登入驗證方法
  
- **Controller**: `api/app/Controllers/AuthController.php`
  - 處理登入、註冊、登出 API
  - 使用 JWT 進行認證
  
- **Helper**: `api/app/Helpers/jwt_helper.php`
  - JWT token 生成和驗證功能
  
- **CORS**: `api/app/Config/Cors.php`
  - 配置跨域請求

### 前端 (Nuxt4)

- **Composable**: `admin/app/composables/useAuth.ts`
  - 提供認證相關的功能
  - 管理使用者狀態
  - 處理 token 儲存
  
- **Middleware**: `admin/app/middleware/auth.ts`
  - 保護需要認證的路由
  - 自動導向登入頁
  
- **登入頁面**: `admin/app/pages/login.vue`
  - 美觀的登入介面
  - 包含註冊功能

## 安全性建議

1. **更改 JWT 金鑰**: 請務必在 `api/env` 中設定一個強隨機的 `JWT_SECRET_KEY`
2. **使用 HTTPS**: 在生產環境中，請使用 HTTPS 協定
3. **定期更新依賴**: 保持所有套件更新到最新版本
4. **密碼強度**: 考慮實施更嚴格的密碼政策
5. **限流**: 實施 API 請求限流以防止暴力攻擊
6. **Token 過期**: JWT token 預設 7 天過期，可根據需求調整

## 疑難排解

### CORS 錯誤

如果遇到 CORS 錯誤，請檢查：
1. `api/app/Config/Cors.php` 中的 `allowedOrigins` 是否包含您的前端 URL
2. `api/app/Config/Filters.php` 中是否已啟用 CORS filter

### 登入失敗

如果登入總是失敗，請檢查：
1. 資料庫中的使用者 `status` 欄位是否為 `active`
2. 密碼是否正確
3. API 伺服器是否正常運行
4. 瀏覽器控制台是否有錯誤訊息

### Token 無效

如果 token 總是被認為無效：
1. 確認前後端的 `JWT_SECRET_KEY` 一致
2. 檢查 token 是否已過期
3. 確認 Authorization header 格式正確

## 下一步

建議實施的額外功能：

1. 忘記密碼 / 重設密碼
2. 電子郵件驗證
3. 二次驗證 (2FA)
4. 使用者管理頁面
5. 權限控制系統
6. 登入歷史記錄

