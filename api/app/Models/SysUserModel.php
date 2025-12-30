<?php

namespace App\Models;

use CodeIgniter\Model;

class SysUserModel extends Model
{
    protected $table            = 'sys_users';
    protected $primaryKey       = 'id';
    protected $useAutoIncrement = true;
    protected $returnType       = 'array';
    protected $useSoftDeletes   = false;
    protected $protectFields    = true;
    protected $allowedFields    = [
        // 兼容新 RBAC 資料表與舊欄位名稱
        'login_id',
        'email',
        'password',
        'name',
        'status',
        'pic',
        'profile',
        'last_login_at',
        // 兼容升級欄位（舊密碼暫存）
        'legacy_password',
        'legacy_algo',
    ];

    // Dates
    protected $useTimestamps = true;
    protected $dateFormat    = 'datetime';
    protected $createdField  = 'created_at';
    protected $updatedField  = 'updated_at';
    protected $deletedField  = 'deleted_at';

    // Validation
    protected $validationRules = [
        'login_id' => 'required|min_length[3]|max_length[100]|is_unique[users.login_id,id,{id}]',
        'email'    => 'required|valid_email|is_unique[users.email,id,{id}]',
        'password' => 'required|min_length[8]',
        'role'     => 'in_list[admin,user,manager]',
        'status'   => 'in_list[active,inactive,suspended]',
    ];

    protected $validationMessages = [
        'login_id' => [
            'required'    => '使用者名稱為必填',
            'min_length'  => '登入帳號至少需要 3 個字元',
            'is_unique'   => '此登入帳號已被使用',
        ],
        'email' => [
            'required'    => '電子郵件為必填',
            'valid_email' => '請輸入有效的電子郵件',
            'is_unique'   => '此電子郵件已被註冊',
        ],
        'password' => [
            'required'   => '密碼為必填',
            'min_length' => '密碼至少需要 8 個字元',
        ],
    ];

    protected $skipValidation = false;
    protected $cleanValidationRules = true;

    // Callbacks
    protected $beforeInsert = ['hashPassword'];
    protected $beforeUpdate = ['hashPassword'];

    /**
     * 確保資料庫連線有效，如果無效則重連
     * 用於處理 "MySQL server has gone away" 錯誤
     */
    protected function ensureConnection()
    {
        try {
            // 檢查連線是否存在
            if (!$this->db->connID) {
                $this->db->initialize();
                return;
            }
            
            // 對於 MySQLi，檢查連線是否還活著
            if ($this->db->DBDriver === 'MySQLi') {
                // 檢查連線物件的錯誤狀態
                if (isset($this->db->connID->errno)) {
                    $errno = $this->db->connID->errno;
                    // 2006 = MySQL server has gone away
                    // 2013 = Lost connection to MySQL server
                    if ($errno === 2006 || $errno === 2013) {
                        log_message('info', 'Database connection lost, attempting to reconnect. Error: ' . $errno);
                        $this->db->reconnect();
                        return;
                    }
                }
                
                // 嘗試執行一個簡單的 ping 查詢來檢查連線
                // 使用 @ 抑制錯誤，因為我們會自己處理
                $result = @$this->db->connID->ping();
                if (!$result) {
                    log_message('info', 'Database connection ping failed, attempting to reconnect.');
                    $this->db->reconnect();
                }
            }
        } catch (\Exception $e) {
            // 如果發生錯誤，嘗試重連
            log_message('warning', 'Database connection check failed: ' . $e->getMessage() . ', attempting to reconnect.');
            try {
                $this->db->reconnect();
            } catch (\Exception $reconnectException) {
                log_message('error', 'Database reconnection failed: ' . $reconnectException->getMessage());
            }
        }
    }

    /**
     * 密碼雜湊處理
     */
    protected function hashPassword(array $data)
    {
        if (isset($data['data']['password'])) {
            $password = $data['data']['password'];
            
            // 檢查密碼是否已經被加密（避免雙重加密）
            // password_get_info() 對於未加密的字串會返回 ['algo' => 0]
            $passwordInfo = password_get_info($password);
            if ($passwordInfo['algo'] === 0) {
                // 只有當密碼是明碼時才進行加密
                $data['data']['password'] = password_hash($password, PASSWORD_DEFAULT);
            }
            // 如果密碼已經被加密，則保持原樣
        }
        return $data;
    }

    /**
     * 驗證登入
     */
    public function verifyLogin(string $username, string $password)
    {
        // 確保資料庫連線有效
        $this->ensureConnection();
        
        $username = trim($username);
        $password = (string) $password;

        // 以新欄位 login_id 或 email 查詢（保留 email 當帳號輸入），使用不區分大小寫
        $builder = $this->builder();
        $builder->groupStart()
                    ->where('LOWER(login_id)', strtolower($username))
                 ->groupEnd()
                ->orGroupStart()
                    ->where('LOWER(email)', strtolower($username))
                ->groupEnd();
        $user = $builder->get()->getRowArray();

        if (!$user) {
            log_message('warning', 'Login failed: user not found. username=' . $username);
            return false;
        }

        if (!isset($user['status']) || $user['status'] !== 'active') {
            log_message('warning', 'Login failed: user status not active. user_id=' . $user['id'] . ' status=' . ($user['status'] ?? 'null'));
            return false;
        }

        $passwordVerified = false;

        // 先嘗試新雜湊（bcrypt/argon）
        if (!empty($user['password']) && password_get_info($user['password'])['algo'] !== 0) {
            $passwordVerified = password_verify($password, $user['password']);
            if (!$passwordVerified) {
                log_message('info', 'Login hash verify failed for user_id=' . $user['id']);
            }
        }

        // 若新雜湊比對失敗，嘗試「兼容升級」：使用 legacy_password（明碼）比對
        if (!$passwordVerified) {
            $legacyAlgo = $user['legacy_algo'] ?? null;
            $legacyPassword = $user['legacy_password'] ?? null;
            if (!empty($legacyPassword) && ($legacyAlgo === 'plain' || $legacyAlgo === null)) {
                if (hash_equals($legacyPassword, $password)) {
                    // 升級：將輸入密碼改為新演算法雜湊，清除 legacy 欄位
                    $this->update($user['id'], [
                        'password'        => password_hash($password, PASSWORD_DEFAULT),
                        'legacy_password' => null,
                        'legacy_algo'     => null,
                        'last_login_at'   => date('Y-m-d H:i:s'),
                    ]);
                    // 重新抓取使用者最新資料
                    $user = $this->find($user['id']);
                    $passwordVerified = true;
                } else {
                    log_message('info', 'Login legacy verify failed for user_id=' . $user['id']);
                }
            } else {
                log_message('info', 'Login legacy not available for user_id=' . $user['id']);
            }
        }

        if (!$passwordVerified) {
            log_message('warning', 'Login failed: password verification failed. user_id=' . $user['id']);
            return false;
        }

        // 更新最後登入時間
        $this->update($user['id'], ['last_login_at' => date('Y-m-d H:i:s')]);

        // 不回傳密碼
        unset($user['password']);
        unset($user['legacy_password'], $user['legacy_algo']);

        return $user;
    }

    /**
     * 取得使用者資料（不含密碼）
     */
    public function getUserById(int $id)
    {
        // 確保資料庫連線有效
        $this->ensureConnection();
        
        $user = $this->find($id);
        if ($user) {
            unset($user['password']);
        }
        return $user;
    }

    /**
     * 取得所有使用者（不含密碼）
     */
    public function getAllUsers()
    {
        // 確保資料庫連線有效
        $this->ensureConnection();
        
        $users = $this->findAll();
        
        // 移除所有使用者的密碼欄位
        foreach ($users as &$user) {
            unset($user['password']);
        }
        
        return $users;
    }
}

