<?php

/**
 * 資料庫連線測試腳本
 * 
 * 此腳本用於測試 MySQL 資料庫連線是否正常
 * 使用方法: php test_db_connection.php
 */

// 讀取環境變數檔案
$envFile = __DIR__ . DIRECTORY_SEPARATOR . 'env';
$config = [
    'hostname' => 'localhost',
    'port' => 3306,
    'database' => 'manthiri',
    'username' => 'root',
    'password' => '',
    'DBDriver' => 'MySQLi',
    'charset' => 'utf8mb4',
];

// 從 env 檔案讀取配置
if (file_exists($envFile)) {
    $lines = file($envFile, FILE_IGNORE_NEW_LINES | FILE_SKIP_EMPTY_LINES);
    foreach ($lines as $line) {
        if (strpos(trim($line), '#') === 0) {
            continue; // 跳過註解
        }
        if (strpos($line, '=') !== false) {
            list($key, $value) = explode('=', $line, 2);
            $key = trim($key);
            $value = trim($value);
            
            if ($key === 'database.default.hostname') {
                $config['hostname'] = $value;
            } elseif ($key === 'database.default.port') {
                $config['port'] = (int)$value;
            } elseif ($key === 'database.default.database') {
                $config['database'] = $value;
            } elseif ($key === 'database.default.username') {
                $config['username'] = $value;
            } elseif ($key === 'database.default.password') {
                $config['password'] = $value;
            }
        }
    }
}

echo "========================================\n";
echo "資料庫連線測試\n";
echo "========================================\n\n";

echo "連線資訊:\n";
echo "  主機: {$config['hostname']}\n";
echo "  埠號: {$config['port']}\n";
echo "  資料庫: {$config['database']}\n";
echo "  使用者: {$config['username']}\n";
echo "  密碼: " . (empty($config['password']) ? '(空)' : '***') . "\n";
echo "  驅動: {$config['DBDriver']}\n";
echo "  字元集: {$config['charset']}\n\n";

// 測試 1: 使用原生 mysqli 連線
echo "測試 1: 使用原生 mysqli 連線...\n";
try {
    $mysqli = new mysqli(
        $config['hostname'],
        $config['username'],
        $config['password'],
        $config['database'],
        $config['port']
    );
    
    if ($mysqli->connect_error) {
        echo "  ❌ 連線失敗: {$mysqli->connect_error}\n";
        echo "  錯誤代碼: {$mysqli->connect_errno}\n\n";
    } else {
        echo "  ✅ 連線成功!\n";
        echo "  伺服器版本: {$mysqli->server_info}\n";
        echo "  主機資訊: {$mysqli->host_info}\n";
        
        // 測試查詢
        $result = $mysqli->query("SELECT VERSION() as version, DATABASE() as db");
        if ($result) {
            $row = $result->fetch_assoc();
            echo "  MySQL 版本: {$row['version']}\n";
            echo "  當前資料庫: {$row['db']}\n";
        }
        
        $mysqli->close();
        echo "\n";
    }
} catch (Exception $e) {
    echo "  ❌ 發生例外: {$e->getMessage()}\n\n";
}

// 測試 2: 測試資料庫和表
echo "測試 2: 測試資料庫和表...\n";
try {
    $mysqli2 = new mysqli(
        $config['hostname'],
        $config['username'],
        $config['password'],
        $config['database'],
        $config['port']
    );
    
    if ($mysqli2->connect_error) {
        echo "  ❌ 連線失敗: {$mysqli2->connect_error}\n\n";
    } else {
        echo "  ✅ 連線成功!\n";
        
        // 測試查詢 users 表
        echo "\n  測試查詢 users 表...\n";
        $result = $mysqli2->query("SHOW TABLES LIKE 'users'");
        if ($result && $result->num_rows > 0) {
            echo "  ✅ users 表存在\n";
            
            // 計算記錄數
            $countResult = $mysqli2->query("SELECT COUNT(*) as count FROM users");
            if ($countResult) {
                $row = $countResult->fetch_assoc();
                echo "  ✅ users 表共有 {$row['count']} 筆記錄\n";
            }
        } else {
            echo "  ⚠️  users 表不存在\n";
        }
        
        $mysqli2->close();
        echo "\n";
    }
} catch (Exception $e) {
    echo "  ❌ 發生例外: {$e->getMessage()}\n\n";
}

// 測試 3: 檢查 MySQL 服務狀態
echo "測試 3: 檢查 MySQL 服務狀態...\n";
if (function_exists('mysqli_connect')) {
    echo "  ✅ mysqli 擴充已安裝\n";
} else {
    echo "  ❌ mysqli 擴充未安裝\n";
}

// 測試 4: 測試連線超時設定
echo "\n測試 4: 連線超時測試...\n";
$startTime = microtime(true);
try {
    $testMysqli = @new mysqli(
        $config['hostname'],
        $config['username'],
        $config['password'],
        $config['database'],
        $config['port']
    );
    $endTime = microtime(true);
    $duration = round(($endTime - $startTime) * 1000, 2);
    
    if (!$testMysqli->connect_error) {
        echo "  ✅ 連線時間: {$duration} 毫秒\n";
        $testMysqli->close();
    }
} catch (Exception $e) {
    echo "  ❌ 連線超時或失敗\n";
}

echo "\n========================================\n";
echo "測試完成\n";
echo "========================================\n";

