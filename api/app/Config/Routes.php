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
$routes->post('/structure/add', 'StructureController::add');
$routes->post('/structure/update', 'StructureController::update');
$routes->post('/structure/update-sort-order', 'StructureController::updateSortOrder');
$routes->post('/structure/delete', 'StructureController::delete');
$routes->get('/structure/get', 'StructureController::get');

// 模組相關路由
$routes->post('/module/add', 'ModuleController::add');
$routes->post('/module/update', 'ModuleController::update');
$routes->post('/module/delete', 'ModuleController::delete');
$routes->get('/module/get', 'ModuleController::get');
