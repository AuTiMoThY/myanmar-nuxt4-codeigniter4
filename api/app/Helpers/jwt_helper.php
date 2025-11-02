<?php

use Firebase\JWT\JWT;
use Firebase\JWT\Key;

if (!function_exists('generateJWT')) {
    /**
     * 生成 JWT Token
     *
     * @param array $user 使用者資料
     * @return string
     */
    function generateJWT(array $user): string
    {
        $key = getenv('JWT_SECRET_KEY') ?: 'your-secret-key-change-in-production';
        $issuedAt = time();
        $expireAt = $issuedAt + (60 * 60 * 24 * 7); // 7 天有效

        $payload = [
            'iat'     => $issuedAt,
            'exp'     => $expireAt,
            'user_id' => $user['id'],
            'username' => $user['username'],
            'email'   => $user['email'],
            'role'    => $user['role'],
        ];

        return JWT::encode($payload, $key, 'HS256');
    }
}

if (!function_exists('verifyJWT')) {
    /**
     * 驗證 JWT Token
     *
     * @param string $token
     * @return object|false
     */
    function verifyJWT(string $token)
    {
        try {
            $key = getenv('JWT_SECRET_KEY') ?: 'your-secret-key-change-in-production';
            return JWT::decode($token, new Key($key, 'HS256'));
        } catch (\Exception $e) {
            log_message('error', 'JWT 驗證失敗: ' . $e->getMessage());
            return false;
        }
    }
}

