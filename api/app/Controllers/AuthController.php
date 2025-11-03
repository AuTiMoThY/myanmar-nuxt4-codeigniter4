<?php

namespace App\Controllers;

use App\Models\UserModel;
use CodeIgniter\HTTP\ResponseInterface;
use CodeIgniter\RESTful\ResourceController;

class AuthController extends ResourceController
{
    protected $format = 'json';
    protected $userModel;

    public function __construct()
    {
        $this->userModel = new UserModel();
        helper('jwt'); // 我們稍後會建立這個 helper
    }

    /**
     * 使用者登入
     */
    public function login()
    {
        $rules = [
            'username' => 'required',
            'password' => 'required',
        ];

        if (!$this->validate($rules)) {
            return $this->fail($this->validator->getErrors(), ResponseInterface::HTTP_BAD_REQUEST);
        }

        $username = $this->request->getVar('username');
        $password = $this->request->getVar('password');

        $user = $this->userModel->verifyLogin($username, $password);

        if (!$user) {
            return $this->fail('使用者名稱或密碼錯誤', ResponseInterface::HTTP_UNAUTHORIZED);
        }

        // 生成 JWT token
        $token = generateJWT($user);

        return $this->respond([
            'status'  => 'success',
            'message' => '登入成功',
            'data'    => [
                'user'  => $user,
                'token' => $token,
            ],
        ], ResponseInterface::HTTP_OK);
    }

    /**
     * 取得當前使用者資料
     */
    public function me()
    {
        try {
            $token = $this->getBearerToken();
            
            if (!$token) {
                return $this->fail('未提供認證 token', ResponseInterface::HTTP_UNAUTHORIZED);
            }

            $decoded = verifyJWT($token);
            
            if (!$decoded) {
                return $this->fail('無效的 token', ResponseInterface::HTTP_UNAUTHORIZED);
            }

            $user = $this->userModel->getUserById($decoded->user_id);

            if (!$user) {
                return $this->fail('找不到使用者', ResponseInterface::HTTP_NOT_FOUND);
            }

            return $this->respond([
                'status' => 'success',
                'data'   => $user,
            ], ResponseInterface::HTTP_OK);
        } catch (\Exception $e) {
            return $this->fail($e->getMessage(), ResponseInterface::HTTP_UNAUTHORIZED);
        }
    }

    /**
     * 登出（前端處理，清除 token）
     */
    public function logout()
    {
        return $this->respond([
            'status'  => 'success',
            'message' => '登出成功',
        ], ResponseInterface::HTTP_OK);
    }

    /**
     * 註冊新使用者
     */
    public function register()
    {
        $rules = [
            'username'  => 'required|min_length[3]|max_length[100]|is_unique[users.username]',
            'email'     => 'required|valid_email|is_unique[users.email]',
            'password'  => 'required|min_length[8]',
            'full_name' => 'permit_empty|max_length[255]',
        ];

        if (!$this->validate($rules)) {
            return $this->fail($this->validator->getErrors(), ResponseInterface::HTTP_BAD_REQUEST);
        }

        $data = [
            'username'  => $this->request->getVar('username'),
            'email'     => $this->request->getVar('email'),
            'password'  => $this->request->getVar('password'),
            'full_name' => $this->request->getVar('full_name'),
            'role'      => 'user', // 預設角色
            'status'    => 'active',
        ];

        $userId = $this->userModel->insert($data);

        if (!$userId) {
            return $this->fail('註冊失敗', ResponseInterface::HTTP_INTERNAL_SERVER_ERROR);
        }

        $user = $this->userModel->getUserById($userId);

        // 自動登入
        $token = generateJWT($user);

        return $this->respond([
            'status'  => 'success',
            'message' => '註冊成功',
            'data'    => [
                'user'  => $user,
                'token' => $token,
            ],
        ], ResponseInterface::HTTP_CREATED);
    }

    /**
     * 取得所有使用者列表
     */
    public function getUsers()
    {
        try {
            $token = $this->getBearerToken();
            
            if (!$token) {
                return $this->fail('未提供認證 token', ResponseInterface::HTTP_UNAUTHORIZED);
            }

            $decoded = verifyJWT($token);
            
            if (!$decoded) {
                return $this->fail('無效的 token', ResponseInterface::HTTP_UNAUTHORIZED);
            }

            // 可選：檢查是否有管理員權限
            // $currentUser = $this->userModel->getUserById($decoded->user_id);
            // if ($currentUser['role'] !== 'admin') {
            //     return $this->fail('沒有權限', ResponseInterface::HTTP_FORBIDDEN);
            // }

            $users = $this->userModel->getAllUsers();

            return $this->respond([
                'status' => 'success',
                'data'   => $users,
            ], ResponseInterface::HTTP_OK);
        } catch (\Exception $e) {
            return $this->fail($e->getMessage(), ResponseInterface::HTTP_INTERNAL_SERVER_ERROR);
        }
    }

    /**
     * 從 Header 取得 Bearer Token
     */
    private function getBearerToken()
    {
        $header = $this->request->getHeaderLine('Authorization');
        
        if (!empty($header)) {
            if (preg_match('/Bearer\s(\S+)/', $header, $matches)) {
                return $matches[1];
            }
        }
        
        return null;
    }
}

