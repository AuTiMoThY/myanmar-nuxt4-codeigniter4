<?php

use CodeIgniter\Router\RouteCollection;

/**
 * @var RouteCollection $routes
 */
$routes->get('/', 'Home::index');

// Auth Routes
$routes->group('api', ['namespace' => 'App\Controllers'], function ($routes) {
    // OPTIONS 請求（用於 CORS preflight）
    $routes->options('auth/login', function() {
        return service('response')->setStatusCode(200);
    });
    $routes->options('auth/register', function() {
        return service('response')->setStatusCode(200);
    });
    $routes->options('auth/logout', function() {
        return service('response')->setStatusCode(200);
    });
    $routes->options('auth/me', function() {
        return service('response')->setStatusCode(200);
    });
    
    // 公開路由
    $routes->post('auth/login', 'AuthController::login');
    $routes->post('auth/register', 'AuthController::register');
    
    // 需要認證的路由
    $routes->post('auth/logout', 'AuthController::logout');
    $routes->get('auth/me', 'AuthController::me');
});
