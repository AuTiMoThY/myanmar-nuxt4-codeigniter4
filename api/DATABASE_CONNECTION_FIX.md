# MySQL Server Has Gone Away 錯誤說明與解決方案

## 錯誤說明

**"MySQL server has gone away"** 這個錯誤表示：

1. **連線已斷開**：MySQL 伺服器關閉了與應用程式的連線
2. **常見原因**：
   - 連線閒置時間過長（超過 `wait_timeout`，預設通常是 28800 秒 = 8 小時）
   - MySQL 服務重啟或當機
   - 網路連線中斷
   - 查詢資料過大，超過 `max_allowed_packet` 限制
   - 連線池中的連線已失效但仍被重用

## 從您的日誌分析

從 `log-2025-11-22.log` 第 411-412 行可以看到：
- 錯誤發生在登入時（`api/auth/login`）
- 當嘗試查詢 `users` 表時發生
- 時間：2025-11-22 06:57:46

這表示在登入請求時，資料庫連線已經失效，但 CodeIgniter 仍嘗試使用舊的連線。

## 解決方案

### 方案 1：在 Model 中加入連線檢查（推薦）

在 `UserModel` 中加入連線檢查和自動重連機制：

```php
/**
 * 確保資料庫連線有效，如果無效則重連
 */
protected function ensureConnection()
{
    try {
        // 檢查連線是否存在且有效
        if (!$this->db->connID) {
            $this->db->initialize();
            return;
        }
        
        // 對於 MySQLi，檢查連線是否還活著
        if ($this->db->DBDriver === 'MySQLi') {
            // 嘗試執行一個簡單的查詢來檢查連線
            @$this->db->query("SELECT 1");
            if ($this->db->connID->errno === 2006 || $this->db->connID->errno === 2013) {
                // 2006 = MySQL server has gone away
                // 2013 = Lost connection to MySQL server
                $this->db->reconnect();
            }
        }
    } catch (\Exception $e) {
        // 如果發生錯誤，嘗試重連
        $this->db->reconnect();
    }
}
```

然後在 `verifyLogin` 方法開始時呼叫：

```php
public function verifyLogin(string $username, string $password)
{
    // 確保連線有效
    $this->ensureConnection();
    
    // ... 其餘程式碼
}
```

### 方案 2：修改資料庫配置（較簡單但可能影響效能）

在 `app/Config/Database.php` 中，將 `pConnect` 設為 `false`（目前已經是 false，這是正確的），並考慮加入連線超時設定。

### 方案 3：調整 MySQL 設定（需要 MySQL 管理權限）

如果可能，調整 MySQL 的 `wait_timeout` 和 `interactive_timeout` 設定：

```sql
SET GLOBAL wait_timeout = 28800;
SET GLOBAL interactive_timeout = 28800;
```

或在 `my.cnf` 或 `my.ini` 中設定：

```ini
[mysqld]
wait_timeout = 28800
interactive_timeout = 28800
```

## 建議

1. **立即解決**：採用方案 1，在 Model 中加入連線檢查
2. **長期優化**：考慮使用連線池或定期檢查連線狀態
3. **監控**：持續監控日誌，如果錯誤頻繁出現，可能需要調整 MySQL 設定

## 測試

執行 `php test_db_connection.php` 來測試資料庫連線是否正常。

