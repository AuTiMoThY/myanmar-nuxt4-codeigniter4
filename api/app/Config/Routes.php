<?php

use CodeIgniter\Router\RouteCollection;

/**
 * @var RouteCollection $routes
 */
$routes->get('/', 'Home::index');
$routes->get('/test-db-connection', 'testDbConnection::index');
$routes->get('/test-db-connection2', 'testDbConnection2::index');
$routes->get('/test-cors', 'TestCors::index');


// 讓 preflight OPTIONS 不落 404（CORS filter 仍會附加 headers）
$routes->options('/(:any)', 'Home::options');

// 公開路由
$routes->post('auth/login', 'AuthController::login');
$routes->post('auth/register', 'AuthController::register');

// 需要認證的路由
$routes->post('auth/logout', 'AuthController::logout');
$routes->get('auth/me', 'AuthController::me');
$routes->get('auth/users', 'AuthController::getUsers');
$routes->get('auth/users/(:num)', 'AuthController::getUser/$1');
$routes->put('auth/users/(:num)', 'AuthController::updateUser/$1');

// 系統架構層級相關路由
$routes->post('/structure/add', 'SysStructureController::add');
$routes->post('/structure/update', 'SysStructureController::update');
$routes->post('/structure/update-sort-order', 'SysStructureController::updateSortOrder');
$routes->post('/structure/delete', 'SysStructureController::delete');
$routes->get('/structure/get', 'SysStructureController::get');

// 模組相關路由
$routes->post('/module/add', 'SysModuleController::add');
$routes->post('/module/update', 'SysModuleController::update');
$routes->post('/module/delete', 'SysModuleController::delete');
$routes->get('/module/get', 'SysModuleController::get');
