<?php

namespace App\Models;

use CodeIgniter\Model;

class UserModel extends Model
{
    protected $table            = 'users';
    protected $primaryKey       = 'id';
    protected $useAutoIncrement = true;
    protected $returnType       = 'array';
    protected $useSoftDeletes   = true;
    protected $protectFields    = true;
    protected $allowedFields    = [
        'username',
        'email',
        'password',
        'full_name',
        'role',
        'status',
        'avatar',
        'last_login',
    ];

    // Dates
    protected $useTimestamps = true;
    protected $dateFormat    = 'datetime';
    protected $createdField  = 'created_at';
    protected $updatedField  = 'updated_at';
    protected $deletedField  = 'deleted_at';

    // Validation
    protected $validationRules = [
        'username' => 'required|min_length[3]|max_length[100]|is_unique[users.username,id,{id}]',
        'email'    => 'required|valid_email|is_unique[users.email,id,{id}]',
        'password' => 'required|min_length[8]',
        'role'     => 'in_list[admin,user,manager]',
        'status'   => 'in_list[active,inactive,suspended]',
    ];

    protected $validationMessages = [
        'username' => [
            'required'    => '使用者名稱為必填',
            'min_length'  => '使用者名稱至少需要 3 個字元',
            'is_unique'   => '此使用者名稱已被使用',
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
     * 密碼雜湊處理
     */
    protected function hashPassword(array $data)
    {
        if (isset($data['data']['password'])) {
            $data['data']['password'] = password_hash($data['data']['password'], PASSWORD_DEFAULT);
        }
        return $data;
    }

    /**
     * 驗證登入
     */
    public function verifyLogin(string $username, string $password)
    {
        $user = $this->where('username', $username)
                     ->orWhere('email', $username)
                     ->first();

        if (!$user) {
            return false;
        }

        if ($user['status'] !== 'active') {
            return false;
        }

        if (!password_verify($password, $user['password'])) {
            return false;
        }

        // 更新最後登入時間
        $this->update($user['id'], ['last_login' => date('Y-m-d H:i:s')]);

        // 不回傳密碼
        unset($user['password']);

        return $user;
    }

    /**
     * 取得使用者資料（不含密碼）
     */
    public function getUserById(int $id)
    {
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
        $users = $this->findAll();
        
        // 移除所有使用者的密碼欄位
        foreach ($users as &$user) {
            unset($user['password']);
        }
        
        return $users;
    }
}

