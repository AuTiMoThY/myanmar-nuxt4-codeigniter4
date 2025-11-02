<?php

namespace App\Database\Seeds;

use CodeIgniter\Database\Seeder;

class UserSeeder extends Seeder
{
    public function run()
    {
        // 建立預設管理員帳號
        $data = [
            [
                'username'   => 'admin',
                'email'      => 'admin@example.com',
                'password'   => password_hash('password123', PASSWORD_DEFAULT),
                'full_name'  => 'Administrator',
                'role'       => 'admin',
                'status'     => 'active',
                'created_at' => date('Y-m-d H:i:s'),
            ],
            [
                'username'   => 'user',
                'email'      => 'user@example.com',
                'password'   => password_hash('password123', PASSWORD_DEFAULT),
                'full_name'  => 'Test User',
                'role'       => 'user',
                'status'     => 'active',
                'created_at' => date('Y-m-d H:i:s'),
            ],
        ];

        // 插入資料
        $this->db->table('users')->insertBatch($data);

        echo "使用者種子資料已成功建立！\n";
        echo "管理員帳號 - 帳號: admin, 密碼: password123\n";
        echo "一般使用者 - 帳號: user, 密碼: password123\n";
    }
}

