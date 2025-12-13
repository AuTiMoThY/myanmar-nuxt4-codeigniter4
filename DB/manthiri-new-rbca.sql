-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- 主機： localhost:3306
-- 產生時間： 2025-11-22 06:32:01
-- 伺服器版本： 8.4.3
-- PHP 版本： 8.3.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- 資料庫： `manthiri`
--

-- --------------------------------------------------------

--
-- 資料表結構 `migrations`
--

CREATE TABLE `migrations` (
  `id` bigint UNSIGNED NOT NULL,
  `version` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `class` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `group` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `namespace` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `time` int NOT NULL,
  `batch` int UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 傾印資料表的資料 `migrations`
--

INSERT INTO `migrations` (`id`, `version`, `class`, `group`, `namespace`, `time`, `batch`) VALUES
(1, '2025-11-02-000001', 'App\\Database\\Migrations\\CreateUsersTable', 'default', 'App', 1762096663, 1);

-- --------------------------------------------------------

--
-- 資料表結構 `permissions`
--

CREATE TABLE `permissions` (
  `id` int UNSIGNED NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '權限識別名稱 (如: product.view)',
  `display_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '權限顯示名稱',
  `description` text COLLATE utf8mb4_unicode_ci COMMENT '權限描述',
  `module` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '所屬模組 (如: product, finance)',
  `category` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '分類 (如: tw, sg, mm, s2t)',
  `action` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '動作 (如: view, create, edit, delete)',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='權限表';

--
-- 傾印資料表的資料 `permissions`
--

INSERT INTO `permissions` (`id`, `name`, `display_name`, `description`, `module`, `category`, `action`, `created_at`, `updated_at`) VALUES
(1, 'system.manage', '系統管理', '系統設定管理', 'system', NULL, 'manage', '2025-11-16 06:38:57', '2025-11-16 06:38:57'),
(2, 'user.view', '查看使用者', '查看使用者列表', 'user', NULL, 'view', '2025-11-16 06:38:57', '2025-11-16 06:38:57'),
(3, 'user.create', '新增使用者', '新增使用者帳號', 'user', NULL, 'create', '2025-11-16 06:38:57', '2025-11-16 06:38:57'),
(4, 'user.edit', '編輯使用者', '編輯使用者資料', 'user', NULL, 'edit', '2025-11-16 06:38:57', '2025-11-16 06:38:57'),
(5, 'user.delete', '刪除使用者', '刪除使用者帳號', 'user', NULL, 'delete', '2025-11-16 06:38:57', '2025-11-16 06:38:57'),
(6, 'user.manage', '管理使用者', '完整管理使用者', 'user', NULL, 'manage', '2025-11-16 06:38:57', '2025-11-16 06:38:57'),
(7, 'product.view', '查看產品', '查看產品列表和詳情', 'product', NULL, 'view', '2025-11-16 06:38:57', '2025-11-16 06:38:57'),
(8, 'product.create', '新增產品', '新增產品資料', 'product', NULL, 'create', '2025-11-16 06:38:57', '2025-11-16 06:38:57'),
(9, 'product.edit', '編輯產品', '編輯產品資料', 'product', NULL, 'edit', '2025-11-16 06:38:57', '2025-11-16 06:38:57'),
(10, 'product.delete', '刪除產品', '刪除產品', 'product', NULL, 'delete', '2025-11-16 06:38:57', '2025-11-16 06:38:57'),
(11, 'product.tw.manage', '管理台灣產品', '完整管理台灣區產品', 'product', 'tw', 'manage', '2025-11-16 06:38:57', '2025-11-16 06:38:57'),
(12, 'product.sg.manage', '管理新加坡產品', '完整管理新加坡區產品', 'product', 'sg', 'manage', '2025-11-16 06:38:57', '2025-11-16 06:38:57'),
(13, 'product.mm.manage', '管理緬甸產品', '完整管理緬甸區產品', 'product', 'mm', 'manage', '2025-11-16 06:38:57', '2025-11-16 06:38:57'),
(14, 'product.keyin', '產品輸入', '新增產品輸入', 'product', NULL, 'keyin', '2025-11-16 06:38:57', '2025-11-16 06:38:57'),
(15, 'member.view', '查看會員', '查看會員資料', 'member', NULL, 'view', '2025-11-16 06:38:57', '2025-11-16 06:38:57'),
(16, 'member.create', '新增會員', '新增會員', 'member', NULL, 'create', '2025-11-16 06:38:57', '2025-11-16 06:38:57'),
(17, 'member.edit', '編輯會員', '編輯會員資料', 'member', NULL, 'edit', '2025-11-16 06:38:57', '2025-11-16 06:38:57'),
(18, 'member.delete', '刪除會員', '刪除會員', 'member', NULL, 'delete', '2025-11-16 06:38:57', '2025-11-16 06:38:57'),
(19, 'member.tw.manage', '管理台灣會員', '完整管理台灣會員', 'member', 'tw', 'manage', '2025-11-16 06:38:57', '2025-11-16 06:38:57'),
(20, 'member.sg.manage', '管理新加坡會員', '完整管理新加坡會員', 'member', 'sg', 'manage', '2025-11-16 06:38:57', '2025-11-16 06:38:57'),
(21, 'member.mm.manage', '管理緬甸會員', '完整管理緬甸會員', 'member', 'mm', 'manage', '2025-11-16 06:38:57', '2025-11-16 06:38:57'),
(22, 'member.rent.view', '查看租賃會員', '查看租賃會員資料', 'member', 'rent', 'view', '2025-11-16 06:38:57', '2025-11-16 06:38:57'),
(23, 'member.rent.sg.manage', '管理新加坡租賃會員', '', 'member', 'rent_sg', 'manage', '2025-11-16 06:38:57', '2025-11-16 06:38:57'),
(24, 'member.rent.mm.manage', '管理緬甸租賃會員', '', 'member', 'rent_mm', 'manage', '2025-11-16 06:38:57', '2025-11-16 06:38:57'),
(25, 'finance.view', '查看財務', '查看財務報表', 'finance', NULL, 'view', '2025-11-16 06:38:57', '2025-11-16 06:38:57'),
(26, 'finance.create', '新增財務', '新增財務記錄', 'finance', NULL, 'create', '2025-11-16 06:38:57', '2025-11-16 06:38:57'),
(27, 'finance.edit', '編輯財務', '編輯財務資料', 'finance', NULL, 'edit', '2025-11-16 06:38:57', '2025-11-16 06:38:57'),
(28, 'finance.delete', '刪除財務', '刪除財務記錄', 'finance', NULL, 'delete', '2025-11-16 06:38:57', '2025-11-16 06:38:57'),
(29, 'finance.setting.manage', '財務設定', '財務設定管理', 'finance', 'setting', 'manage', '2025-11-16 06:38:57', '2025-11-16 06:38:57'),
(30, 'finance.s2t.view', '查看財務-新加坡到台灣', '', 'finance', 's2t', 'view', '2025-11-16 06:38:57', '2025-11-16 06:38:57'),
(31, 'finance.s2t.edit', '編輯財務-新加坡到台灣', '', 'finance', 's2t', 'edit', '2025-11-16 06:38:57', '2025-11-16 06:38:57'),
(32, 'finance.s2t.print', '列印財務-新加坡到台灣', '', 'finance', 's2t', 'print', '2025-11-16 06:38:57', '2025-11-16 06:38:57'),
(33, 'finance.s2t.print_hint', '列印提示-新加坡到台灣', '', 'finance', 's2t', 'print_hint', '2025-11-16 06:38:57', '2025-11-16 06:38:57'),
(34, 'finance.s2t.goods_reference', '商品參考-新加坡到台灣', '', 'finance', 's2t', 'goods_reference', '2025-11-16 06:38:57', '2025-11-16 06:38:57'),
(35, 'finance.s2t.print_goods', '列印商品-新加坡到台灣', '', 'finance', 's2t', 'print_goods', '2025-11-16 06:38:57', '2025-11-16 06:38:57'),
(36, 'finance.s2y.view', '查看財務-新加坡到緬甸', '', 'finance', 's2y', 'view', '2025-11-16 06:38:57', '2025-11-16 06:38:57'),
(37, 'finance.s2y.print_hint', '列印提示-新加坡到緬甸', '', 'finance', 's2y', 'print_hint', '2025-11-16 06:38:57', '2025-11-16 06:38:57'),
(38, 'finance.t2s.view', '查看財務-台灣到新加坡', '', 'finance', 't2s', 'view', '2025-11-16 06:38:57', '2025-11-16 06:38:57'),
(39, 'finance.t2s.print_hint', '列印提示-台灣到新加坡', '', 'finance', 't2s', 'print_hint', '2025-11-16 06:38:57', '2025-11-16 06:38:57'),
(40, 'finance.y2s.view', '查看財務-緬甸到新加坡', '', 'finance', 'y2s', 'view', '2025-11-16 06:38:57', '2025-11-16 06:38:57'),
(41, 'finance.y2t.view', '查看財務-緬甸到台灣', '', 'finance', 'y2t', 'view', '2025-11-16 06:38:57', '2025-11-16 06:38:57'),
(42, 'finance.trans.tw', '財務轉帳-台灣', '', 'finance', 'trans_tw', 'manage', '2025-11-16 06:38:57', '2025-11-16 06:38:57'),
(43, 'finance.trans.sg', '財務轉帳-新加坡', '', 'finance', 'trans_sg', 'manage', '2025-11-16 06:38:57', '2025-11-16 06:38:57'),
(44, 'finance.trans.mm', '財務轉帳-緬甸', '', 'finance', 'trans_mm', 'manage', '2025-11-16 06:38:57', '2025-11-16 06:38:57'),
(45, 'purchase.view', '查看採購', '查看採購記錄', 'purchase', NULL, 'view', '2025-11-16 06:38:57', '2025-11-16 06:38:57'),
(46, 'purchase.create', '新增採購', '新增採購單', 'purchase', NULL, 'create', '2025-11-16 06:38:57', '2025-11-16 06:38:57'),
(47, 'purchase.edit', '編輯採購', '編輯採購資料', 'purchase', NULL, 'edit', '2025-11-16 06:38:57', '2025-11-16 06:38:57'),
(48, 'purchase.delete', '刪除採購', '刪除採購記錄', 'purchase', NULL, 'delete', '2025-11-16 06:38:57', '2025-11-16 06:38:57'),
(49, 'purchase.print_hint', '列印採購提示', '', 'purchase', NULL, 'print_hint', '2025-11-16 06:38:57', '2025-11-16 06:38:57'),
(50, 'purchase.keyin.sg', '採購輸入-新加坡', '', 'purchase', 'keyin_sg', 'create', '2025-11-16 06:38:57', '2025-11-16 06:38:57'),
(51, 'purchase.keyin.mm', '採購輸入-緬甸', '', 'purchase', 'keyin_mm', 'create', '2025-11-16 06:38:57', '2025-11-16 06:38:57'),
(52, 'deliver.view', '查看出貨', '查看出貨記錄', 'deliver', NULL, 'view', '2025-11-16 06:38:57', '2025-11-16 06:38:57'),
(53, 'deliver.create', '新增出貨', '新增出貨單', 'deliver', NULL, 'create', '2025-11-16 06:38:57', '2025-11-16 06:38:57'),
(54, 'deliver.edit', '編輯出貨', '編輯出貨資料', 'deliver', NULL, 'edit', '2025-11-16 06:38:57', '2025-11-16 06:38:57'),
(55, 'deliver.setting.manage', '出貨設定', '出貨設定管理', 'deliver', 'setting', 'manage', '2025-11-16 06:38:57', '2025-11-16 06:38:57'),
(56, 'download.manage', '下載管理', NULL, 'download', NULL, 'manage', '2025-11-16 06:38:57', '2025-11-16 06:38:57');

-- --------------------------------------------------------

--
-- 資料表結構 `roles`
--

CREATE TABLE `roles` (
  `id` int UNSIGNED NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '角色識別名稱 (英文)',
  `display_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '角色顯示名稱',
  `description` text COLLATE utf8mb4_unicode_ci COMMENT '角色描述',
  `is_system` tinyint(1) DEFAULT '0' COMMENT '是否為系統預設角色 (不可刪除)',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='角色表';

--
-- 傾印資料表的資料 `roles`
--

INSERT INTO `roles` (`id`, `name`, `display_name`, `description`, `is_system`, `created_at`, `updated_at`) VALUES
(1, 'super_admin', '超級管理員', '擁有系統所有權限，可管理一切', 1, '2025-11-16 06:38:57', '2025-11-16 06:38:57'),
(2, 'admin', '管理員', '一般管理員權限', 1, '2025-11-16 06:38:57', '2025-11-16 06:38:57'),
(3, 'finance_manager_tw', '財務主管-台灣', '台灣財務相關完整權限', 0, '2025-11-16 06:38:57', '2025-11-16 06:38:57'),
(4, 'finance_manager_sg', '財務主管-新加坡', '新加坡財務相關完整權限', 0, '2025-11-16 06:38:57', '2025-11-16 06:38:57'),
(5, 'finance_manager_mm', '財務主管-緬甸', '緬甸財務相關完整權限', 0, '2025-11-16 06:38:57', '2025-11-16 06:38:57'),
(6, 'product_manager', '產品主管', '產品管理完整權限', 0, '2025-11-16 06:38:57', '2025-11-16 06:38:57'),
(7, 'purchase_manager', '採購主管', '採購管理完整權限', 0, '2025-11-16 06:38:57', '2025-11-16 06:38:57'),
(8, 'deliver_manager', '出貨主管', '出貨管理完整權限', 0, '2025-11-16 06:38:57', '2025-11-16 06:38:57'),
(9, 'sales_tw', '業務-台灣', '台灣銷售權限', 0, '2025-11-16 06:38:57', '2025-11-16 06:38:57'),
(10, 'sales_sg', '業務-新加坡', '新加坡銷售權限', 0, '2025-11-16 06:38:57', '2025-11-16 06:38:57'),
(11, 'sales_mm', '業務-緬甸', '緬甸銷售權限', 0, '2025-11-16 06:38:57', '2025-11-16 06:38:57'),
(12, 'warehouse_tw', '倉管-台灣', '台灣倉庫管理權限', 0, '2025-11-16 06:38:57', '2025-11-16 06:38:57'),
(13, 'warehouse_sg', '倉管-新加坡', '新加坡倉庫管理權限', 0, '2025-11-16 06:38:57', '2025-11-16 06:38:57'),
(14, 'warehouse_mm', '倉管-緬甸', '緬甸倉庫管理權限', 0, '2025-11-16 06:38:57', '2025-11-16 06:38:57'),
(15, 'member_service', '會員服務', '會員管理相關權限', 0, '2025-11-16 06:38:57', '2025-11-16 06:38:57'),
(16, 'viewer', '訪客', '僅查看權限', 0, '2025-11-16 06:38:57', '2025-11-16 06:38:57');

-- --------------------------------------------------------

--
-- 資料表結構 `role_permissions`
--

CREATE TABLE `role_permissions` (
  `id` bigint UNSIGNED NOT NULL,
  `role_id` int UNSIGNED NOT NULL COMMENT '角色ID',
  `permission_id` int UNSIGNED NOT NULL COMMENT '權限ID',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='角色-權限關聯表';

--
-- 傾印資料表的資料 `role_permissions`
--

INSERT INTO `role_permissions` (`id`, `role_id`, `permission_id`, `created_at`) VALUES
(1, 1, 52, '2025-11-16 06:38:57'),
(2, 1, 53, '2025-11-16 06:38:57'),
(3, 1, 54, '2025-11-16 06:38:57'),
(4, 1, 55, '2025-11-16 06:38:57'),
(5, 1, 56, '2025-11-16 06:38:57'),
(6, 1, 25, '2025-11-16 06:38:57'),
(7, 1, 26, '2025-11-16 06:38:57'),
(8, 1, 27, '2025-11-16 06:38:57'),
(9, 1, 28, '2025-11-16 06:38:57'),
(10, 1, 29, '2025-11-16 06:38:57'),
(11, 1, 30, '2025-11-16 06:38:57'),
(12, 1, 31, '2025-11-16 06:38:57'),
(13, 1, 32, '2025-11-16 06:38:57'),
(14, 1, 33, '2025-11-16 06:38:57'),
(15, 1, 34, '2025-11-16 06:38:57'),
(16, 1, 35, '2025-11-16 06:38:57'),
(17, 1, 36, '2025-11-16 06:38:57'),
(18, 1, 37, '2025-11-16 06:38:57'),
(19, 1, 38, '2025-11-16 06:38:57'),
(20, 1, 39, '2025-11-16 06:38:57'),
(21, 1, 40, '2025-11-16 06:38:57'),
(22, 1, 41, '2025-11-16 06:38:57'),
(23, 1, 42, '2025-11-16 06:38:57'),
(24, 1, 43, '2025-11-16 06:38:57'),
(25, 1, 44, '2025-11-16 06:38:57'),
(26, 1, 15, '2025-11-16 06:38:57'),
(27, 1, 16, '2025-11-16 06:38:57'),
(28, 1, 17, '2025-11-16 06:38:57'),
(29, 1, 18, '2025-11-16 06:38:57'),
(30, 1, 19, '2025-11-16 06:38:57'),
(31, 1, 20, '2025-11-16 06:38:57'),
(32, 1, 21, '2025-11-16 06:38:57'),
(33, 1, 22, '2025-11-16 06:38:57'),
(34, 1, 23, '2025-11-16 06:38:57'),
(35, 1, 24, '2025-11-16 06:38:57'),
(36, 1, 7, '2025-11-16 06:38:57'),
(37, 1, 8, '2025-11-16 06:38:57'),
(38, 1, 9, '2025-11-16 06:38:57'),
(39, 1, 10, '2025-11-16 06:38:57'),
(40, 1, 11, '2025-11-16 06:38:57'),
(41, 1, 12, '2025-11-16 06:38:57'),
(42, 1, 13, '2025-11-16 06:38:57'),
(43, 1, 14, '2025-11-16 06:38:57'),
(44, 1, 45, '2025-11-16 06:38:57'),
(45, 1, 46, '2025-11-16 06:38:57'),
(46, 1, 47, '2025-11-16 06:38:57'),
(47, 1, 48, '2025-11-16 06:38:57'),
(48, 1, 49, '2025-11-16 06:38:57'),
(49, 1, 50, '2025-11-16 06:38:57'),
(50, 1, 51, '2025-11-16 06:38:57'),
(51, 1, 1, '2025-11-16 06:38:57'),
(52, 1, 2, '2025-11-16 06:38:57'),
(53, 1, 3, '2025-11-16 06:38:57'),
(54, 1, 4, '2025-11-16 06:38:57'),
(55, 1, 5, '2025-11-16 06:38:57'),
(56, 1, 6, '2025-11-16 06:38:57');

-- --------------------------------------------------------

--
-- 資料表結構 `sys_loginsystem`
--

CREATE TABLE `sys_loginsystem` (
  `sysloginID` bigint UNSIGNED NOT NULL,
  `loginID` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `time` datetime DEFAULT NULL,
  `pic` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `profile` text,
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `expiration_chk` int NOT NULL DEFAULT '0',
  `expiration_date` date DEFAULT NULL,
  `note_finance` longtext,
  `note_deliver` longtext,
  `note_purchase` longtext,
  `power_product` int UNSIGNED NOT NULL DEFAULT '0',
  `power_product_sg` int UNSIGNED NOT NULL DEFAULT '0',
  `power_product_mm` int UNSIGNED NOT NULL DEFAULT '0',
  `power_member` int UNSIGNED NOT NULL DEFAULT '0',
  `power_memberRent` int UNSIGNED NOT NULL DEFAULT '0',
  `power_rent` int UNSIGNED NOT NULL DEFAULT '0',
  `power_finance` int UNSIGNED NOT NULL DEFAULT '0',
  `power_finance_s2t` int UNSIGNED NOT NULL DEFAULT '0',
  `power_finance_s2y` int UNSIGNED NOT NULL DEFAULT '0',
  `power_finance_t2s` int UNSIGNED NOT NULL DEFAULT '0',
  `power_finance_y2s` int UNSIGNED NOT NULL DEFAULT '0',
  `power_finance_y2t` int UNSIGNED NOT NULL DEFAULT '0',
  `power_finance_print_hint` int UNSIGNED NOT NULL DEFAULT '0',
  `power_finance_s2t_print_hint` int UNSIGNED NOT NULL DEFAULT '0',
  `power_finance_s2y_print_hint` int UNSIGNED NOT NULL DEFAULT '0',
  `power_finance_t2s_print_hint` int UNSIGNED NOT NULL DEFAULT '0',
  `power_finance_y2s_print_hint` int UNSIGNED NOT NULL DEFAULT '0',
  `power_finance_y2t_print_hint` int UNSIGNED NOT NULL DEFAULT '0',
  `power_finance_goods_reference` int UNSIGNED NOT NULL DEFAULT '0',
  `power_finance_s2t_goods_reference` int UNSIGNED NOT NULL DEFAULT '0',
  `power_finance_s2y_goods_reference` int UNSIGNED NOT NULL DEFAULT '0',
  `power_finance_t2s_goods_reference` int UNSIGNED NOT NULL DEFAULT '0',
  `power_finance_y2s_goods_reference` int UNSIGNED NOT NULL DEFAULT '0',
  `power_finance_y2t_goods_reference` int UNSIGNED NOT NULL DEFAULT '0',
  `power_finance_print_goods` int UNSIGNED NOT NULL DEFAULT '0',
  `power_finance_s2t_print_goods` int UNSIGNED NOT NULL DEFAULT '0',
  `power_finance_s2y_print_goods` int UNSIGNED NOT NULL DEFAULT '0',
  `power_finance_t2s_print_goods` int UNSIGNED NOT NULL DEFAULT '0',
  `power_finance_y2s_print_goods` int UNSIGNED NOT NULL DEFAULT '0',
  `power_finance_y2t_print_goods` int UNSIGNED NOT NULL DEFAULT '0',
  `power_new_deliver` int UNSIGNED NOT NULL DEFAULT '0',
  `power_new_deliver_s2t` int UNSIGNED NOT NULL DEFAULT '0',
  `power_new_deliver_s2y` int UNSIGNED NOT NULL DEFAULT '0',
  `power_new_deliver_t2s` int UNSIGNED NOT NULL DEFAULT '0',
  `power_new_deliver_y2s` int UNSIGNED NOT NULL DEFAULT '0',
  `power_new_deliver_y2t` int UNSIGNED NOT NULL DEFAULT '0',
  `power_deliver` int UNSIGNED NOT NULL DEFAULT '0',
  `power_deliverb2t` int UNSIGNED NOT NULL DEFAULT '0',
  `power_delivercarryb2t` int UNSIGNED NOT NULL DEFAULT '0',
  `power_delivercarryt2b` int UNSIGNED NOT NULL DEFAULT '0',
  `power_deliver_b2t` int UNSIGNED NOT NULL DEFAULT '0',
  `power_deliver_t2b` int UNSIGNED NOT NULL DEFAULT '0',
  `power_purchase` int UNSIGNED NOT NULL DEFAULT '0',
  `power_purchaseb2s` int UNSIGNED NOT NULL DEFAULT '0',
  `power_purchaseb2t` int UNSIGNED NOT NULL DEFAULT '0',
  `power_purchases2b` int UNSIGNED NOT NULL DEFAULT '0',
  `power_purchases2t` int UNSIGNED NOT NULL DEFAULT '0',
  `power_purchaset2s` int UNSIGNED NOT NULL DEFAULT '0',
  `power_purchase_print_hint` int UNSIGNED NOT NULL DEFAULT '0',
  `power_purchase_print_hint_b2s` int UNSIGNED NOT NULL DEFAULT '0',
  `power_purchase_print_hint_b2t` int UNSIGNED NOT NULL DEFAULT '0',
  `power_purchase_print_hint_s2b` int UNSIGNED NOT NULL DEFAULT '0',
  `power_purchase_print_hint_s2t` int UNSIGNED NOT NULL DEFAULT '0',
  `power_purchase_print_hint_t2s` int UNSIGNED NOT NULL DEFAULT '0',
  `power_download` int UNSIGNED NOT NULL DEFAULT '0',
  `power_system` int UNSIGNED NOT NULL DEFAULT '0',
  `power_login` int UNSIGNED NOT NULL DEFAULT '0',
  `power_member_singapore` int UNSIGNED NOT NULL DEFAULT '0',
  `power_member_myanmar` int UNSIGNED NOT NULL DEFAULT '0',
  `power_memberRent_singapore` int UNSIGNED NOT NULL DEFAULT '0',
  `power_memberRent_myanmar` int UNSIGNED NOT NULL DEFAULT '0',
  `power_in_out_singapore` int UNSIGNED NOT NULL DEFAULT '0',
  `power_in_out_myanmar` int UNSIGNED NOT NULL DEFAULT '0',
  `power_in_out` int UNSIGNED NOT NULL DEFAULT '0',
  `power_finance_setting` int UNSIGNED NOT NULL DEFAULT '0',
  `power_exchange_setting` int UNSIGNED NOT NULL DEFAULT '0',
  `power_income_text_setting` int UNSIGNED NOT NULL DEFAULT '0',
  `power_deliver_setting` int UNSIGNED NOT NULL DEFAULT '0',
  `power_feedback_setting` int UNSIGNED NOT NULL DEFAULT '0',
  `power_shopping` int UNSIGNED NOT NULL DEFAULT '0',
  `power_pos_sale_report` int UNSIGNED NOT NULL DEFAULT '0',
  `power_pos_sale_report_sg` int UNSIGNED NOT NULL DEFAULT '0',
  `power_pos_sale_report_mm` int UNSIGNED NOT NULL DEFAULT '0',
  `power_pos_expense` int UNSIGNED NOT NULL DEFAULT '0',
  `power_pos_expense_sg` int UNSIGNED NOT NULL DEFAULT '0',
  `power_pos_expense_mm` int UNSIGNED NOT NULL DEFAULT '0',
  `power_pos_member` int UNSIGNED NOT NULL DEFAULT '0',
  `power_pos_marquee` int UNSIGNED NOT NULL DEFAULT '0',
  `power_pos_marquee_sg` int UNSIGNED NOT NULL DEFAULT '0',
  `power_pos_marquee_mm` int UNSIGNED NOT NULL DEFAULT '0',
  `power_pos_cus_marquee` int UNSIGNED NOT NULL DEFAULT '0',
  `power_pos_cus_marquee_sg` int UNSIGNED NOT NULL DEFAULT '0',
  `power_pos_cus_marquee_mm` int UNSIGNED NOT NULL DEFAULT '0',
  `power_pos_store_income` int UNSIGNED NOT NULL DEFAULT '0',
  `power_pos_store_income_sg` int UNSIGNED NOT NULL DEFAULT '0',
  `power_pos_store_income_mm` int UNSIGNED NOT NULL DEFAULT '0',
  `power_pos_store_income_pim_in` int UNSIGNED NOT NULL DEFAULT '0',
  `power_pos_store_income_pim_out` int UNSIGNED NOT NULL DEFAULT '0',
  `power_staff` int UNSIGNED NOT NULL DEFAULT '0',
  `power_staff_modify` int UNSIGNED NOT NULL DEFAULT '0',
  `power_staff_salary_input` int UNSIGNED NOT NULL DEFAULT '0',
  `power_staff_print` int UNSIGNED NOT NULL DEFAULT '0',
  `power_finance_trans_tw` int UNSIGNED NOT NULL DEFAULT '0',
  `power_finance_trans_sg` int UNSIGNED NOT NULL DEFAULT '0',
  `power_finance_trans_mm` int UNSIGNED NOT NULL DEFAULT '0',
  `power_new_product_keyin` int UNSIGNED NOT NULL DEFAULT '0',
  `power_new_purchase_keyin` int UNSIGNED NOT NULL DEFAULT '0',
  `power_new_purchase_keyin_sg` int UNSIGNED NOT NULL DEFAULT '0',
  `power_new_purchase_keyin_mm` int UNSIGNED NOT NULL DEFAULT '0',
  `power_pos_sale_system` int UNSIGNED NOT NULL DEFAULT '0',
  `power_pos_sale_system_sg` int UNSIGNED NOT NULL DEFAULT '0',
  `power_pos_sale_system_mm` int UNSIGNED NOT NULL DEFAULT '0',
  `power_pos_rtn_system` int UNSIGNED NOT NULL DEFAULT '0',
  `power_pos_rtn_system_sg` int UNSIGNED NOT NULL DEFAULT '0',
  `power_pos_rtn_system_mm` int UNSIGNED NOT NULL DEFAULT '0',
  `power_poe` int UNSIGNED NOT NULL DEFAULT '0',
  `power_poe_country` int UNSIGNED NOT NULL DEFAULT '0',
  `power_poe_exchange` int UNSIGNED NOT NULL DEFAULT '0',
  `power_poe_bill_setting` int UNSIGNED NOT NULL DEFAULT '0',
  `power_poe_stock_report` int UNSIGNED NOT NULL DEFAULT '0',
  `power_poe_chat` int UNSIGNED NOT NULL DEFAULT '0',
  `power_poe_print` int UNSIGNED NOT NULL DEFAULT '0',
  `power_poe_admin` int UNSIGNED NOT NULL DEFAULT '0',
  `power_poe_chat_admin` int UNSIGNED NOT NULL DEFAULT '0',
  `power_poe_customer_type` int UNSIGNED NOT NULL DEFAULT '0',
  `power_ktv` int UNSIGNED NOT NULL DEFAULT '1',
  `power_ktv_sg` int UNSIGNED NOT NULL DEFAULT '0',
  `power_ktv_mm` int UNSIGNED NOT NULL DEFAULT '0',
  `power_pre_finance` int UNSIGNED NOT NULL DEFAULT '0',
  `power_pre_finance_s2t` int UNSIGNED NOT NULL DEFAULT '0',
  `power_pre_finance_s2y` int UNSIGNED NOT NULL DEFAULT '0',
  `power_pre_finance_t2s` int UNSIGNED NOT NULL DEFAULT '0',
  `power_pre_finance_y2s` int UNSIGNED NOT NULL DEFAULT '0',
  `power_pre_finance_y2t` int UNSIGNED NOT NULL DEFAULT '0',
  `power_pre_finance_from_tw` int UNSIGNED NOT NULL DEFAULT '0',
  `power_pre_finance_from_sg` int UNSIGNED NOT NULL DEFAULT '0',
  `power_pre_finance_from_mm` int UNSIGNED NOT NULL DEFAULT '0',
  `power_pre_finance_to_tw` int UNSIGNED NOT NULL DEFAULT '0',
  `power_pre_finance_to_sg` int UNSIGNED NOT NULL DEFAULT '0',
  `power_pre_finance_to_mm` int UNSIGNED NOT NULL DEFAULT '0',
  `power_pre_finance_approve` int UNSIGNED NOT NULL DEFAULT '0',
  `power_pre_finance_s2t_approve` int UNSIGNED NOT NULL DEFAULT '0',
  `power_pre_finance_s2y_approve` int UNSIGNED NOT NULL DEFAULT '0',
  `power_pre_finance_t2s_approve` int UNSIGNED NOT NULL DEFAULT '0',
  `power_pre_finance_y2s_approve` int UNSIGNED NOT NULL DEFAULT '0',
  `power_pre_finance_y2t_approve` int UNSIGNED NOT NULL DEFAULT '0',
  `power_pre_finance_from_tw_approve` int UNSIGNED NOT NULL DEFAULT '0',
  `power_pre_finance_from_sg_approve` int UNSIGNED NOT NULL DEFAULT '0',
  `power_pre_finance_from_mm_approve` int UNSIGNED NOT NULL DEFAULT '0',
  `power_pre_finance_to_tw_approve` int UNSIGNED NOT NULL DEFAULT '0',
  `power_pre_finance_to_sg_approve` int UNSIGNED NOT NULL DEFAULT '0',
  `power_pre_finance_to_mm_approve` int UNSIGNED NOT NULL DEFAULT '0',
  `power_pre_finance_print_hint` int UNSIGNED NOT NULL DEFAULT '0',
  `power_pre_finance_s2t_print_hint` int UNSIGNED NOT NULL DEFAULT '0',
  `power_pre_finance_s2y_print_hint` int UNSIGNED NOT NULL DEFAULT '0',
  `power_pre_finance_t2s_print_hint` int UNSIGNED NOT NULL DEFAULT '0',
  `power_pre_finance_y2s_print_hint` int UNSIGNED NOT NULL DEFAULT '0',
  `power_pre_finance_y2t_print_hint` int UNSIGNED NOT NULL DEFAULT '0',
  `power_pre_finance_from_tw_print_hint` int UNSIGNED NOT NULL DEFAULT '0',
  `power_pre_finance_from_sg_print_hint` int UNSIGNED NOT NULL DEFAULT '0',
  `power_pre_finance_from_mm_print_hint` int UNSIGNED NOT NULL DEFAULT '0',
  `power_pre_finance_to_tw_print_hint` int UNSIGNED NOT NULL DEFAULT '0',
  `power_pre_finance_to_sg_print_hint` int UNSIGNED NOT NULL DEFAULT '0',
  `power_pre_finance_to_mm_print_hint` int UNSIGNED NOT NULL DEFAULT '0',
  `power_pre_finance_print` int UNSIGNED NOT NULL DEFAULT '0',
  `power_pre_finance_s2t_print` int UNSIGNED NOT NULL DEFAULT '0',
  `power_pre_finance_s2y_print` int UNSIGNED NOT NULL DEFAULT '0',
  `power_pre_finance_t2s_print` int UNSIGNED NOT NULL DEFAULT '0',
  `power_pre_finance_y2s_print` int UNSIGNED NOT NULL DEFAULT '0',
  `power_pre_finance_y2t_print` int UNSIGNED NOT NULL DEFAULT '0',
  `power_pre_finance_from_tw_print` int UNSIGNED NOT NULL DEFAULT '0',
  `power_pre_finance_from_sg_print` int UNSIGNED NOT NULL DEFAULT '0',
  `power_pre_finance_from_mm_print` int UNSIGNED NOT NULL DEFAULT '0',
  `power_pre_finance_to_tw_print` int UNSIGNED NOT NULL DEFAULT '0',
  `power_pre_finance_to_sg_print` int UNSIGNED NOT NULL DEFAULT '0',
  `power_pre_finance_to_mm_print` int UNSIGNED NOT NULL DEFAULT '0',
  `power_mm_shopping` int UNSIGNED NOT NULL DEFAULT '0',
  `power_cal_tw` int UNSIGNED NOT NULL DEFAULT '0',
  `power_cal_sg` int UNSIGNED NOT NULL DEFAULT '0',
  `power_cal_mm` int UNSIGNED NOT NULL DEFAULT '0',
  `power_slide_show_tw` int UNSIGNED NOT NULL DEFAULT '0',
  `power_slide_show_sg` int UNSIGNED NOT NULL DEFAULT '0',
  `power_slide_show_mm` int UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

--
-- 傾印資料表的資料 `sys_loginsystem`
--

INSERT INTO `sys_loginsystem` (`sysloginID`, `loginID`, `password`, `time`, `pic`, `name`, `profile`, `create_time`, `update_time`, `expiration_chk`, `expiration_date`, `note_finance`, `note_deliver`, `note_purchase`, `power_product`, `power_product_sg`, `power_product_mm`, `power_member`, `power_memberRent`, `power_rent`, `power_finance`, `power_finance_s2t`, `power_finance_s2y`, `power_finance_t2s`, `power_finance_y2s`, `power_finance_y2t`, `power_finance_print_hint`, `power_finance_s2t_print_hint`, `power_finance_s2y_print_hint`, `power_finance_t2s_print_hint`, `power_finance_y2s_print_hint`, `power_finance_y2t_print_hint`, `power_finance_goods_reference`, `power_finance_s2t_goods_reference`, `power_finance_s2y_goods_reference`, `power_finance_t2s_goods_reference`, `power_finance_y2s_goods_reference`, `power_finance_y2t_goods_reference`, `power_finance_print_goods`, `power_finance_s2t_print_goods`, `power_finance_s2y_print_goods`, `power_finance_t2s_print_goods`, `power_finance_y2s_print_goods`, `power_finance_y2t_print_goods`, `power_new_deliver`, `power_new_deliver_s2t`, `power_new_deliver_s2y`, `power_new_deliver_t2s`, `power_new_deliver_y2s`, `power_new_deliver_y2t`, `power_deliver`, `power_deliverb2t`, `power_delivercarryb2t`, `power_delivercarryt2b`, `power_deliver_b2t`, `power_deliver_t2b`, `power_purchase`, `power_purchaseb2s`, `power_purchaseb2t`, `power_purchases2b`, `power_purchases2t`, `power_purchaset2s`, `power_purchase_print_hint`, `power_purchase_print_hint_b2s`, `power_purchase_print_hint_b2t`, `power_purchase_print_hint_s2b`, `power_purchase_print_hint_s2t`, `power_purchase_print_hint_t2s`, `power_download`, `power_system`, `power_login`, `power_member_singapore`, `power_member_myanmar`, `power_memberRent_singapore`, `power_memberRent_myanmar`, `power_in_out_singapore`, `power_in_out_myanmar`, `power_in_out`, `power_finance_setting`, `power_exchange_setting`, `power_income_text_setting`, `power_deliver_setting`, `power_feedback_setting`, `power_shopping`, `power_pos_sale_report`, `power_pos_sale_report_sg`, `power_pos_sale_report_mm`, `power_pos_expense`, `power_pos_expense_sg`, `power_pos_expense_mm`, `power_pos_member`, `power_pos_marquee`, `power_pos_marquee_sg`, `power_pos_marquee_mm`, `power_pos_cus_marquee`, `power_pos_cus_marquee_sg`, `power_pos_cus_marquee_mm`, `power_pos_store_income`, `power_pos_store_income_sg`, `power_pos_store_income_mm`, `power_pos_store_income_pim_in`, `power_pos_store_income_pim_out`, `power_staff`, `power_staff_modify`, `power_staff_salary_input`, `power_staff_print`, `power_finance_trans_tw`, `power_finance_trans_sg`, `power_finance_trans_mm`, `power_new_product_keyin`, `power_new_purchase_keyin`, `power_new_purchase_keyin_sg`, `power_new_purchase_keyin_mm`, `power_pos_sale_system`, `power_pos_sale_system_sg`, `power_pos_sale_system_mm`, `power_pos_rtn_system`, `power_pos_rtn_system_sg`, `power_pos_rtn_system_mm`, `power_poe`, `power_poe_country`, `power_poe_exchange`, `power_poe_bill_setting`, `power_poe_stock_report`, `power_poe_chat`, `power_poe_print`, `power_poe_admin`, `power_poe_chat_admin`, `power_poe_customer_type`, `power_ktv`, `power_ktv_sg`, `power_ktv_mm`, `power_pre_finance`, `power_pre_finance_s2t`, `power_pre_finance_s2y`, `power_pre_finance_t2s`, `power_pre_finance_y2s`, `power_pre_finance_y2t`, `power_pre_finance_from_tw`, `power_pre_finance_from_sg`, `power_pre_finance_from_mm`, `power_pre_finance_to_tw`, `power_pre_finance_to_sg`, `power_pre_finance_to_mm`, `power_pre_finance_approve`, `power_pre_finance_s2t_approve`, `power_pre_finance_s2y_approve`, `power_pre_finance_t2s_approve`, `power_pre_finance_y2s_approve`, `power_pre_finance_y2t_approve`, `power_pre_finance_from_tw_approve`, `power_pre_finance_from_sg_approve`, `power_pre_finance_from_mm_approve`, `power_pre_finance_to_tw_approve`, `power_pre_finance_to_sg_approve`, `power_pre_finance_to_mm_approve`, `power_pre_finance_print_hint`, `power_pre_finance_s2t_print_hint`, `power_pre_finance_s2y_print_hint`, `power_pre_finance_t2s_print_hint`, `power_pre_finance_y2s_print_hint`, `power_pre_finance_y2t_print_hint`, `power_pre_finance_from_tw_print_hint`, `power_pre_finance_from_sg_print_hint`, `power_pre_finance_from_mm_print_hint`, `power_pre_finance_to_tw_print_hint`, `power_pre_finance_to_sg_print_hint`, `power_pre_finance_to_mm_print_hint`, `power_pre_finance_print`, `power_pre_finance_s2t_print`, `power_pre_finance_s2y_print`, `power_pre_finance_t2s_print`, `power_pre_finance_y2s_print`, `power_pre_finance_y2t_print`, `power_pre_finance_from_tw_print`, `power_pre_finance_from_sg_print`, `power_pre_finance_from_mm_print`, `power_pre_finance_to_tw_print`, `power_pre_finance_to_sg_print`, `power_pre_finance_to_mm_print`, `power_mm_shopping`, `power_cal_tw`, `power_cal_sg`, `power_cal_mm`, `power_slide_show_tw`, `power_slide_show_sg`, `power_slide_show_mm`) VALUES
(12, 'jeffery', '61508210', '2025-09-30 18:32:16', '20130903125406.jpg', 'tw ', '', NULL, '2025-05-08 19:50:29', 0, '0000-00-00', 'å¯„æ¬¾æ³¨æ„äº‹é … 1\r\nå¯„æ¬¾æ³¨æ„äº‹é … 2\r\nå¯„æ¬¾æ³¨æ„äº‹é … 3\r\nå¯„æ¬¾æ³¨æ„äº‹é … 4\r\nå¯„æ¬¾æ³¨æ„äº‹é … 5', 'å¯„è²¨æ³¨æ„äº‹é … 1\r\nå¯„è²¨æ³¨æ„äº‹é … 2\r\nå¯„è²¨æ³¨æ„äº‹é … 3\r\nå¯„è²¨æ³¨æ„äº‹é … 4\r\nå¯„è²¨æ³¨æ„äº‹é … 5', 'è¨‚å–®æ³¨æ„äº‹é … 1\r\nè¨‚å–®æ³¨æ„äº‹é … 2\r\nè¨‚å–®æ³¨æ„äº‹é … 3\r\nè¨‚å–®æ³¨æ„äº‹é … 4\r\nè¨‚å–®æ³¨æ„äº‹é … 5\r\nè¨‚å–®æ³¨æ„äº‹é … 6\r\nè¨‚å–®æ³¨æ„äº‹é … 7', 28, 28, 28, 28, 28, 0, 28, 28, 28, 28, 28, 28, 1, 0, 1, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 0, 14, 14, 14, 14, 28, 28, 1, 1, 1, 1, 1, 1, 28, 28, 28, 28, 28, 28, 1, 1, 1, 1, 1, 1, 28, 28, 28, 28, 28, 0, 0, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 1, 1, 1, 28, 28, 28, 28, 28, 28, 28, 30, 30, 30, 28, 28, 28, 28, 28, 8, 28, 28, 0, 1, 1, 0, 28, 1, 1, 1, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 62, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 3, 2, 1, 5, 4, 0, 0, 0, 0, 0, 0, 28, 28, 30, 28, 28, 28, 28),
(13, 'alex', 'alex123', '2025-10-16 16:27:03', '20130917122339.jpg', '', '', NULL, '2021-02-05 22:21:45', 0, '0000-00-00', NULL, NULL, NULL, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 2, 2, 2, 28, 28, 28, 28, 28, 26, 28, 28, 28, 28, 28, 28, 0, 0, 0, 0, 0, 0, 28, 28, 0, 28, 28, 28, 28, 28, 28, 28, 28, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 30, 0, 0, 0, 0, 0, 28, 28, 0, 28, 28, 0, 0, 0, 0, 28, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(26, 'ygnkkt030', '115330', '2025-08-28 18:28:57', '20130915061132.jpg', 'ygná€á€­á€¯á€„á€¹á€á€­á€¯á€„á€¹á€‘á€¼á€”á€¹á€¸', '', NULL, '2025-04-03 20:36:40', 0, '0000-00-00', NULL, NULL, NULL, 14, 14, 10, 1, 1, 1, 2, 2, 14, 2, 6, 6, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 14, 8, 8, 12, 14, 14, 1, 1, 1, 1, 1, 1, 14, 31, 30, 14, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 14, 6, 14, 1, 1, 14, 14, 14, 1, 30, 30, 30, 30, 1, 1, 6, 6, 6, 14, 14, 6, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 14, 1, 1, 1, 2, 2, 2, 6, 4, 4, 14, 12, 12, 14, 0, 0, 0, 30, 0, 10, 12, 0, 1, 1, 1, 0, 0, 1, 1, 0, 1, 1, 33, 1, 46, 46, 1, 1, 1, 1, 46, 46, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 2, 14, 14, 0, 0, 0),
(22, 'twmanthiri', '61508210', '2019-07-01 19:51:11', '20130922070652.jpg', 'á€‘á€­á€¯á€„á€¹á€á€™á€¹á€†á€­á€¯á€„á€¹', '', NULL, '2019-07-01 19:51:11', 1, '2014-10-04', NULL, NULL, NULL, 14, 1, 13, 14, 30, 1, 31, 11, 1, 11, 1, 15, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 30, 30, 1, 1, 1, 1, 1, 1, 30, 0, 0, 0, 0, 30, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 14, 14, 31, 31, 1, 1, 1, 1, 30, 0, 0, 31, 0, 0, 1, 31, 1, 1, 31, 1, 1, 31, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 14, 15, 0, 0, 14, 0, 14, 0, 0, 0, 15, 3, 10, 15, 1, 2, 1, 1, 0, 1, 0, 1, 0, 15, 3, 3, 3, 3, 3, 3, 3, 3, 15, 31, 31, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0),
(23, 'mac', '131064', '2025-08-28 15:33:31', '', 'tw', '', NULL, '2023-10-17 13:57:19', 0, '0000-00-00', NULL, NULL, NULL, 14, 0, 0, 2, 14, 6, 2, 1, 1, 1, 1, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 14, 1, 1, 1, 1, 1, 1, 14, 1, 15, 1, 1, 2, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 1, 0, 0, 0, 6, 0, 0, 1, 2, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 1, 1, 0, 6, 0, 0, 14, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 47, 1, 1, 1, 33, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 14, 0, 0, 0, 0, 0),
(27, 'maswe', '98626214', '2025-08-26 16:03:38', '', 'sgá€™á€±á€†á€¼', '', NULL, '2025-06-14 17:18:49', 0, '0000-00-00', NULL, NULL, NULL, 1, 1, 1, 1, 1, 1, 0, 2, 2, 0, 2, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 2, 0, 2, 2, 0, 0, 6, 6, 6, 6, 0, 0, 1, 1, 1, 6, 6, 6, 0, 0, 0, 0, 0, 0, 0, 1, 1, 7, 1, 1, 1, 2, 1, 1, 1, 14, 0, 0, 0, 1, 0, 6, 0, 0, 6, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 6, 1, 1, 0, 2, 0, 0, 2, 2, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 1, 1, 1, 34, 1, 1, 1, 1, 1, 34, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0),
(122, 'ygnsoemarlwin', '127408', '2025-08-28 18:22:34', '', 'á€™ á€±á€œá€¸á€…á€­á€¯á€¸á€™á€¬á€œá€¼á€„á€¹', 'á€™ á€±á€œá€¸á€…á€­á€¯á€¸á€™á€¬á€œá€¼á€„á€¹', '2022-11-16 17:39:26', '2024-11-26 20:33:56', 0, '0000-00-00', NULL, NULL, NULL, 0, 0, 0, 0, 0, 0, 2, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 6, 6, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(28, 'htike', 'mtr21245', '2025-08-21 01:16:19', '20130916071207.jpg', 'sgá€™á€±á€†á€¼', '', NULL, '2024-10-31 18:32:04', 0, '2015-06-03', NULL, NULL, NULL, 1, 6, 1, 1, 1, 1, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 14, 0, 0, 14, 0, 0, 0, 0, 0, 0, 0, 0, 1, 6, 1, 6, 6, 6, 0, 0, 0, 0, 0, 0, 1, 1, 1, 14, 6, 1, 1, 6, 1, 1, 1, 6, 0, 0, 0, 1, 0, 6, 0, 0, 6, 0, 6, 1, 6, 0, 0, 6, 0, 0, 1, 0, 0, 0, 15, 0, 0, 0, 2, 6, 2, 0, 0, 6, 0, 0, 6, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 6, 0, 0, 0, 0, 6, 0, 0, 6, 0, 0, 0, 0, 0, 1, 1, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 0, 0, 6, 0, 0, 0, 0),
(32, 'ygnmawai', '105381', '2025-08-27 09:53:45', '', 'ygná€™á€±á€', '', NULL, '2025-06-14 17:17:16', 0, '0000-00-00', NULL, NULL, NULL, 1, 14, 14, 0, 0, 0, 0, 2, 2, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 0, 0, 6, 0, 14, 0, 0, 0, 0, 0, 0, 14, 6, 0, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 0, 0, 14, 0, 0, 0, 0, 0, 6, 0, 0, 2, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 0, 0, 0, 0, 2, 0, 14, 0, 4, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 38, 1, 1, 1, 1, 1, 38, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(33, 'ygnmaaye', '163693', '2025-08-28 17:44:04', '', 'ygná€™á€±á€¡á€¸', '', NULL, '2025-02-16 18:39:34', 0, '0000-00-00', NULL, NULL, NULL, 0, 30, 0, 0, 0, 0, 0, 0, 6, 0, 2, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 14, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 14, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 6, 0, 0, 0, 0, 4, 0, 0, 2, 0, 0, 0, 0, 0, 6, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 6, 0, 14, 0, 0, 0, 0, 14, 0, 0, 0, 0, 30, 8, 8, 8, 0, 0, 1, 1, 0, 0, 0, 1, 0, 0, 0, 38, 0, 0, 0, 0, 0, 0, 0, 38, 38, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0),
(34, 'austin', 'austin', '2018-08-13 12:10:26', '', '', '', NULL, '2018-07-23 18:30:10', 0, '0000-00-00', NULL, NULL, NULL, 2, 2, 2, 2, 1, 1, 1, 30, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 1, 2, 2, 1, 1, 1, 1, 1, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 30, 30, 30, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(35, 'mdymtr', '4034012', '2025-08-28 13:53:59', '', 'mdyá€™á€žá€¶', '', NULL, '2025-03-21 20:41:04', 0, '0000-00-00', NULL, NULL, NULL, 0, 0, 30, 0, 0, 0, 2, 0, 2, 0, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 1, 0, 6, 30, 2, 0, 0, 0, 0, 0, 0, 0, 30, 30, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 0, 0, 0, 30, 2, 0, 0, 0, 0, 0, 0, 0, 0, 14, 0, 0, 14, 30, 6, 6, 14, 0, 0, 14, 0, 0, 14, 0, 0, 14, 0, 1, 0, 0, 0, 0, 6, 0, 0, 0, 0, 2, 30, 0, 0, 30, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 38, 38, 0, 0, 0, 0, 38, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 14, 0, 0, 0),
(54, 'ailin', 'ailin', '2025-08-28 18:03:05', '', 'tw á€€á€ºá€¶á€³á€¸á€œá€­', '', NULL, '2025-03-31 17:32:01', 0, '0000-00-00', NULL, NULL, NULL, 2, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 14, 0, 0, 0, 0, 0, 0, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0),
(126, 'mp3', 'mp3', '2023-08-26 17:48:53', '', 'for customer', '', '2023-08-26 17:23:03', '2023-08-26 17:30:07', 1, '2024-09-10', NULL, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(127, 'aungmyintmyat', 'aung1224', '2025-07-10 17:02:12', '', 'Aung Myint Myat', '', '2024-03-24 09:45:47', '2025-03-18 17:21:34', 0, '0000-00-00', NULL, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 14, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 14, 0, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 38, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(42, 'maysukyi', '543479', '2025-08-28 17:47:16', '', 'á€±á€™á€…á€¯á¾á€€á€Šá€¹  ygn', '', NULL, '2025-06-14 17:16:20', 0, '2018-12-01', NULL, NULL, NULL, 0, 30, 0, 0, 0, 0, 0, 6, 4, 4, 6, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 14, 1, 1, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 14, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 6, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 2, 12, 0, 14, 0, 0, 0, 0, 4, 12, 0, 0, 0, 2, 10, 10, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 38, 0, 0, 0, 0, 0, 38, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0),
(43, 'ygnmtrttl', '5134353', '2024-11-10 16:19:15', '', 'á€‘á€¼á€”á€¹á€¸á€‘á€¼á€”á€¹á€¸á€œá€„á€¹á€¸  ygn', '', NULL, '2020-01-07 02:01:04', 0, '0000-00-00', NULL, NULL, NULL, 0, 0, 0, 0, 0, 0, 2, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(130, 'ygnkhantkhaaung', '230414', '2024-10-29 15:04:31', '', 'á€›á€”á€¹á€€á€¯á€”á€¹á€†á€¯á€­á€„á€¹ á€á€”á€¹á‚•á€á€±á€¡á€¬á€„á€¹', '', '2024-09-25 17:46:20', '2024-09-25 17:58:37', 0, '0000-00-00', NULL, NULL, NULL, 0, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 12, 0, 0, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(46, 'ygnsoesoe', '281080', '2024-11-07 16:15:08', '', 'á€…á€­á€¯á€¸á€…á€­á€¯á€¸  ygn', '', NULL, '2020-01-07 02:01:49', 0, '0000-00-00', NULL, NULL, NULL, 0, 0, 0, 0, 0, 0, 2, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(47, 'ygnphonemincho', '145090', '2025-08-10 14:31:10', '', 'á€–á€¯á€”á€¹á€¸á€™á€„á€¹á€¸á€á€ºá€­á€³ ygn', '', NULL, '2024-05-06 18:33:22', 0, '0000-00-00', NULL, NULL, NULL, 2, 10, 0, 0, 0, 0, 2, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 0, 0, 6, 14, 6, 0, 0, 0, 0, 0, 0, 14, 14, 14, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 6, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 14, 14, 14, 14, 6, 6, 14, 0, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(51, 'mdytheingioo2010', '34012', '2025-08-04 15:27:28', '', 'á€žá€­á€‚á¤ á€®á€¦á€¸ mdy', '', NULL, '2021-06-07 11:41:02', 0, '0000-00-00', NULL, NULL, NULL, 0, 0, 30, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 14, 1, 1, 1, 0, 0, 0, 30, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(123, 'ygnzawmyohtwe', '111111', '2025-08-11 19:22:23', '', 'ygnzawmyohtwe', 'á€±á€‡á€¬á€¹á€™á€­á€¯á€¸á€±á€‘á€¼á€¸', '2022-11-16 17:40:49', '2025-04-27 09:21:11', 0, '0000-00-00', NULL, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 6, 14, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(55, 'ygnmaythinzarnu', '063925', '2025-07-30 14:33:01', '', 'ygn á€±á€™á€žá€°á€‡á€¬á‚á€¯', '', NULL, '2025-03-27 12:57:42', 0, '0000-00-00', NULL, NULL, NULL, 12, 12, 12, 0, 0, 0, 2, 0, 2, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 14, 14, 14, 14, 14, 14, 0, 0, 0, 0, 0, 0, 14, 0, 0, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 0, 14, 0, 0, 0, 0, 0, 14, 0, 0, 6, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 12, 15, 1, 15, 6, 6, 14, 0, 14, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 38, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 0, 14, 0, 0, 0),
(56, 'mdymamin', '332525', '2025-08-28 12:30:21', '', 'á€™á€™á€„á€¹á€¸ mdy', '', NULL, '2025-06-22 18:59:53', 0, '0000-00-00', NULL, NULL, NULL, 0, 0, 26, 0, 0, 0, 2, 0, 2, 0, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 6, 6, 2, 0, 0, 0, 0, 0, 0, 0, 14, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 14, 0, 0, 14, 30, 0, 0, 14, 0, 0, 14, 0, 0, 14, 0, 0, 14, 1, 1, 1, 0, 0, 0, 14, 0, 0, 0, 0, 2, 30, 0, 0, 30, 14, 2, 2, 2, 0, 0, 0, 1, 0, 2, 1, 0, 0, 0, 0, 38, 0, 38, 38, 0, 0, 0, 0, 36, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(57, 'ygnyannaing', '235678', '2025-08-25 14:47:54', '', 'ygn á€›á€”á€¹á‚á€­á€¯á€„á€¹á€…á€­á€¯á€¸', '', NULL, '2024-07-28 18:33:52', 0, '2015-12-01', NULL, NULL, NULL, 0, 0, 0, 0, 0, 0, 2, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 14, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 38, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(60, 'ygnthwethwe', '181118', '2025-08-25 15:23:01', '', 'á€žá€¼á€šá€¹á€žá€¼á€šá€¹ ygn', '', NULL, '2025-08-06 14:48:56', 0, '0000-00-00', NULL, NULL, NULL, 0, 14, 0, 0, 0, 0, 0, 0, 6, 0, 6, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 14, 0, 0, 0, 0, 14, 0, 0, 0, 0, 0, 0, 14, 14, 14, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 14, 0, 0, 6, 0, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 14, 0, 0, 14, 0, 30, 8, 10, 8, 8, 0, 1, 1, 0, 0, 1, 0, 0, 14, 0, 0, 0, 38, 0, 0, 0, 0, 0, 0, 46, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(62, 'mdycounter', '240613', '2020-10-23 10:19:12', '', 'á€™á€”á€¹á€¸á€±á€œá€¸ á€™á€”á€¹á€¸á€”á€®á€¸á€á€ºá€­á€”á€¹á€‚á€ºá€¬ mdy', '', NULL, '2015-12-09 12:53:23', 0, '0000-00-00', NULL, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 30, 0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(63, 'ygnMT', '201272', '2025-07-23 15:13:23', '', 'á€™á€™á€­á€¯á€¸á€žá€® ygn', '', NULL, '2023-01-11 18:13:42', 0, '0000-00-00', NULL, NULL, NULL, 2, 0, 0, 0, 0, 0, 2, 2, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 4, 0, 0, 0, 0, 0, 0, 6, 0, 6, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 14, 0, 0, 0, 0, 0, 30, 8, 8, 8, 0, 0, 1, 1, 0, 14, 1, 0, 0, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 38, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 0, 14, 0, 0, 0),
(65, 'wuga', '1116', '2024-11-27 13:25:40', '', 'tw', '', NULL, '2019-06-29 15:27:41', 0, '0000-00-00', NULL, NULL, NULL, 14, 0, 0, 14, 30, 0, 10, 2, 0, 2, 0, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 15, 0, 0, 14, 14, 0, 0, 0, 0, 0, 0, 14, 0, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 14, 2, 0, 0, 14, 0, 0, 14, 6, 0, 0, 6, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 14, 0, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 46, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 14, 0, 0, 0, 0, 0),
(66, 's9156112', 's9156112', '2025-08-28 13:17:00', '', 'twá€¡á€á€®á€¸', '', NULL, '2024-08-01 15:03:45', 0, '0000-00-00', NULL, NULL, NULL, 30, 0, 30, 30, 30, 0, 14, 14, 0, 14, 0, 14, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 14, 14, 0, 0, 0, 0, 0, 0, 14, 0, 14, 0, 0, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 30, 30, 0, 0, 0, 0, 14, 0, 14, 0, 0, 0, 14, 14, 0, 0, 14, 0, 0, 14, 12, 0, 0, 14, 0, 0, 14, 0, 0, 0, 0, 14, 0, 0, 0, 14, 0, 0, 0, 14, 0, 14, 14, 0, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 46, 0, 0, 0, 32, 42, 0, 32, 0, 0, 0, 0, 1, 0, 0, 0, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 30, 30, 30, 30, 30, 30),
(67, 'Linkin', '200811', '2025-08-11 09:58:40', '', 'tw', '', NULL, '2016-10-04 13:34:54', 0, '0000-00-00', NULL, NULL, NULL, 12, 0, 0, 14, 30, 0, 6, 0, 0, 2, 0, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 12, 12, 0, 0, 0, 0, 0, 0, 14, 0, 14, 0, 0, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 14, 0, 0, 0, 0, 0, 0, 14, 6, 0, 0, 14, 0, 0, 14, 14, 0, 0, 10, 0, 0, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 14, 0, 0, 14, 0, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 46, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 14, 0, 0, 0, 0, 0),
(68, 'ashang', '131910', '2025-08-24 09:13:44', '', 'tw é˜¿é¦™ á€¡á€¬á€¸á€›á€½á€”á€¹á€¸', '', NULL, '2025-07-11 19:44:45', 0, '0000-00-00', NULL, NULL, NULL, 14, 14, 0, 14, 14, 0, 14, 2, 14, 2, 14, 14, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 14, 1, 0, 14, 12, 12, 0, 0, 0, 0, 0, 0, 14, 0, 14, 14, 0, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 14, 14, 0, 0, 0, 0, 14, 0, 14, 0, 0, 0, 14, 14, 14, 0, 14, 0, 0, 14, 14, 0, 0, 14, 0, 0, 14, 0, 0, 0, 0, 1, 0, 0, 0, 14, 14, 0, 0, 14, 0, 14, 14, 14, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 46, 0, 0, 0, 0, 38, 0, 28, 0, 0, 28, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 12, 0, 0, 0, 0, 0),
(69, 'fatfat', '519888', '2025-08-28 17:24:40', '', 'tw é˜¿ç™¼ á€¡á€–á€á€¹ afat', '', NULL, '2025-04-01 12:45:24', 0, '0000-00-00', NULL, NULL, NULL, 14, 14, 14, 14, 30, 0, 14, 14, 14, 14, 14, 14, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 0, 0, 14, 15, 0, 14, 14, 14, 0, 0, 0, 0, 0, 0, 12, 0, 12, 12, 12, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 14, 14, 0, 0, 0, 0, 14, 0, 14, 0, 0, 0, 14, 14, 14, 0, 14, 14, 0, 14, 14, 0, 0, 14, 0, 0, 14, 14, 0, 0, 0, 0, 0, 0, 0, 14, 14, 0, 14, 14, 0, 14, 30, 30, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 46, 0, 46, 0, 44, 44, 0, 46, 0, 0, 62, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 0, 0, 0, 0, 1, 0, 0, 0, 4, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 30, 30, 30, 30, 30, 30),
(73, 'mama', '1954', '2025-08-28 17:26:26', '', 'twá€™á€¬á€™á€¬á€¸', '', NULL, '2025-05-24 02:24:28', 0, '0000-00-00', NULL, NULL, NULL, 14, 0, 0, 14, 12, 0, 14, 2, 14, 2, 14, 14, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 6, 0, 0, 6, 14, 14, 0, 0, 0, 0, 0, 0, 14, 14, 14, 14, 14, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 0, 14, 0, 0, 0, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 0, 0, 14, 0, 8, 0, 0, 0, 0, 0, 0, 14, 14, 0, 0, 14, 14, 0, 14, 0, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 46, 0, 46, 0, 34, 34, 0, 34, 0, 0, 28, 38, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 14, 14, 14, 0, 0, 0),
(74, 'ygnsusuwin', '202088', '2023-09-12 13:28:21', '', 'á€™á€…á€¯á€…á€¯á€á€„á€¹á€¸ ygn', '', NULL, '2023-09-12 13:28:21', 1, '2023-09-01', NULL, NULL, NULL, 14, 2, 10, 0, 0, 0, 2, 2, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 14, 1, 0, 14, 14, 14, 0, 0, 0, 0, 0, 0, 14, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 6, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 0, 6, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 14, 0, 14, 14, 0, 14, 0, 0, 0, 2, 2, 10, 2, 0, 0, 0, 0, 0, 2, 1, 1, 1, 46, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0),
(76, 'kevin', '1234', '2015-07-21 15:12:32', '', 'å ±é—œè¡ŒKEVIN', '', '2014-09-30 15:36:37', '2015-05-30 18:49:42', 0, '0000-00-00', NULL, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(78, 'zarzar', '123123', '2018-11-01 20:53:05', '', 'sgá€…á€€á¤á€¬á€•á€° ', '', '2014-12-07 16:14:33', '2018-10-25 19:05:06', 0, '2018-01-16', NULL, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 6, 0, 2, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 14, 0, 0, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 14, 0, 14, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(121, 'ygnthetnaingsoe', '000111', '2023-07-20 17:33:53', '', 'á€žá€€á€¹á‚á€­á€¯á€„á€¹á€…á€­á€¯á€¸', 'á€žá€€á€¹á‚á€­á€¯á€„á€¹á€…á€­á€¯á€¸', '2022-10-24 18:44:05', NULL, 0, '0000-00-00', NULL, NULL, NULL, 0, 0, 0, 0, 0, 0, 2, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 4, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(85, 'henrykengemma', 'henry199', '2025-08-28 13:35:37', '', 'twé˜¿å®', '', '2015-11-06 16:39:30', '2018-10-22 01:49:37', 0, '0000-00-00', NULL, NULL, NULL, 30, 0, 30, 14, 14, 0, 2, 0, 0, 0, 0, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 14, 14, 0, 0, 0, 0, 0, 0, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 14, 6, 0, 0, 6, 0, 0, 12, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 30, 0, 10, 0, 0, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 46, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 14, 0, 0, 30, 0, 0),
(80, 'ygnhtetwaiyansoe', '139783', '2025-08-25 18:47:56', '', 'ygná€‘á€€á€¹á€±á€á€šá€¶á€…á€­á€¯á€¸ / á€›á€”á€¹á€€á€¯á€”á€¹á€›á€¶á€¯á€¸', '', '2015-01-20 14:49:30', '2025-07-07 12:22:17', 0, '0000-00-00', NULL, NULL, NULL, 0, 0, 0, 0, 0, 0, 2, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 46, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0),
(81, 'htetlinaung', '693126', '2025-08-28 11:19:45', '', 'á€‘á€€á€¹á€œá€„á€¹á€¸á€±á€¡á€¬á€„á€¹   ygn ', '', '2015-03-17 17:44:49', '2025-06-30 14:40:17', 0, '2018-12-01', NULL, NULL, NULL, 0, 14, 0, 0, 0, 0, 2, 0, 6, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 14, 0, 14, 14, 2, 14, 0, 0, 0, 0, 0, 0, 0, 14, 0, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 12, 0, 0, 6, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 0, 14, 0, 0, 0, 0, 6, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 14, 0, 38, 0, 38, 0, 0, 0, 0, 0, 38, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0),
(82, 'ygnshunshun', '259046937', '2020-03-20 15:19:06', '', 'á€›á€¼á€”á€¹á€¸á€œá€½á€²á‚•á€á€„á€¹á€¸  ygn', '', '2015-05-18 17:52:53', '2020-03-20 15:19:06', 1, '2020-03-19', NULL, NULL, NULL, 6, 6, 14, 0, 0, 0, 2, 0, 6, 0, 6, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 14, 0, 0, 14, 14, 14, 0, 0, 0, 0, 0, 0, 14, 0, 0, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 14, 14, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 14, 0, 1, 1, 0, 0, 0, 6, 14, 14, 14, 6, 4, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 38, 0, 34, 0, 38, 38, 0, 0, 0, 0, 38, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 14, 0, 0, 0),
(84, 'ygnshwezin', '402780466', '2025-08-28 18:28:00', '', 'á€±á€›á‚Šá€‡á€„á€¹ ygn á€±á€›á‚Šá€…á€„á€¹', '', '2015-05-18 17:55:04', '2025-04-03 20:39:30', 0, '0000-00-00', NULL, NULL, NULL, 14, 14, 14, 0, 0, 0, 2, 2, 6, 0, 6, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 14, 0, 14, 14, 14, 14, 0, 0, 0, 0, 0, 0, 14, 0, 0, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 6, 6, 6, 0, 14, 0, 0, 0, 0, 0, 4, 0, 0, 4, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 0, 1, 1, 0, 6, 0, 14, 14, 14, 14, 6, 6, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 34, 0, 1, 0, 46, 38, 0, 0, 0, 0, 38, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 14, 0, 0, 0),
(87, 'manwe', '123', '2020-06-11 13:23:17', '', 'á€™á‚á€¼á€šá€¹ sg', '', '2015-12-07 01:46:04', '2020-06-10 22:51:02', 0, '2020-04-01', NULL, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 38, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(89, 'aiden', '0289230683', '2025-08-26 21:30:25', '', 'é˜¿æ˜‡ aiden', '', '2016-06-14 09:50:51', '2020-01-17 19:34:07', 0, '0000-00-00', NULL, NULL, NULL, 14, 0, 0, 10, 2, 0, 2, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 14, 0, 0, 0, 0, 0, 0, 14, 0, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 14, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 14, 0, 0, 0, 30, 0, 2, 30, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 46, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 14, 0, 0, 0, 0, 0),
(120, 'allen', '123456', '2025-08-17 21:04:09', '', 'é˜¿è€€', '', '2020-05-23 17:34:02', '2025-02-18 16:00:22', 0, '0000-00-00', NULL, NULL, NULL, 14, 14, 14, 2, 0, 0, 2, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 14, 0, 0, 0, 0, 0, 0, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 46, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0),
(91, 'ygnhayman', '81166', '2020-03-20 15:20:12', '', 'á€±á€Ÿá€™á€”á€¹á€™á€ºá€­á€³á€¸ygn', 'á€±á€Ÿá€™á€”á€¹á€™á€ºá€­á€³á€¸', '2016-08-30 17:57:19', '2020-03-20 15:20:12', 1, '2020-03-19', NULL, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 14, 14, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 6, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 14, 14, 14, 0, 0, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(92, 'ygnkaunghtetmoe', '138423', '2025-08-28 11:58:53', '', 'á€›á€”á€¹á€€á€¯á€”á€¹ á€±á€€á€¬á€„á€¹á€¸á€‘á€€á€¹á€™á€­á€¯á€¸', '', '2017-02-02 00:14:26', '2024-11-09 13:19:24', 0, '2022-11-01', NULL, NULL, NULL, 0, 0, 0, 0, 0, 0, 2, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(96, 'ygnnyomee', '199721', '2025-08-28 14:41:42', '', 'ygn á€Šá€­á€³á€™á€®á€œá€­á‚ˆá€„á€¹', '', '2018-11-23 11:25:35', '2025-06-14 17:17:58', 0, '0000-00-00', NULL, NULL, NULL, 14, 14, 14, 0, 0, 0, 2, 2, 6, 0, 6, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 14, 0, 0, 14, 14, 14, 0, 0, 0, 0, 0, 0, 14, 14, 14, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 0, 14, 0, 0, 0, 0, 0, 14, 0, 0, 6, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 14, 0, 0, 0, 12, 0, 12, 0, 0, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 0, 5, 0, 38, 38, 0, 0, 0, 0, 34, 36, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 12, 12),
(93, 'mdyayethan', '123456', '2020-07-28 17:41:56', '', 'MDY á€™á€±á€¡á€¸á€žá€”á€¹á€¸', '', '2018-05-21 14:57:44', '2020-03-13 16:10:20', 0, '0000-00-00', NULL, NULL, NULL, 0, 0, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 14, 0, 0, 2, 14, 2, 0, 0, 0, 0, 0, 0, 0, 14, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 6, 14, 0, 0, 0, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 14, 0, 0, 0, 0, 2, 14, 0, 0, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(94, 'ygnthetnaingsoe', '155621', '2023-07-20 17:33:53', '', 'ygn á€žá€€á€¹á€”á€­á€„á€¹á€…á€­á€¯á€¸', '', '2018-11-21 09:23:04', '2020-01-07 02:06:04', 0, '0000-00-00', NULL, NULL, NULL, 0, 0, 0, 0, 0, 0, 2, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(97, 'ygnhtwehtwe', '252525', '2021-01-18 14:03:58', '', 'ygn shop á€žá€”á€¹á€¸á€žá€”á€¹á€¸á€±á€‘á€¼á€¸', '', '2018-11-23 16:14:16', '2021-01-18 14:03:58', 1, '2021-01-08', NULL, NULL, NULL, 2, 14, 0, 0, 0, 0, 2, 0, 2, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 14, 6, 14, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 14, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 38, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(98, 'yamin', '427633455', '2024-03-19 20:34:16', '', 'á€€á€­á€¯á€¸á€™á€­á€¯á€„á€¹  á€šá€™á€„á€¹á€¸', '', '2019-02-22 15:05:11', '2019-06-05 13:12:54', 0, '0000-00-00', NULL, NULL, NULL, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(99, 'ygnAyeChanMoe', '110512', '2025-08-28 17:41:59', '', 'ygn á€±á€¡á€¸á€á€ºá€™á€¹á€¸á€™á€­á€¯á€¸', '', '2019-04-07 15:28:58', '2024-12-16 11:38:17', 0, '0000-00-00', NULL, NULL, NULL, 0, 0, 0, 0, 0, 0, 2, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 14, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 36, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 4, 0, 0, 0),
(100, 'moezawoo', '79741590', '2019-06-05 13:52:16', '', 'Car spa moe zaw oo', 'á€™á€­á€¯á€¸á€±á€‡á€¬á€¹á€¦á€¸', '2019-06-05 13:52:16', NULL, 0, '0000-00-00', NULL, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(128, 'ygnhlayaminoo', '212199', '2025-08-28 15:26:56', '', 'á€šá€™á€„á€¹á€¸', '', '2024-09-25 16:46:02', NULL, 0, '0000-00-00', NULL, NULL, NULL, 0, 0, 0, 0, 0, 0, 2, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 6, 0, 0, 0, 0, 0, 0, 2, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(129, 'ygnayemon', '105968', '2025-08-19 18:45:25', '', 'á€›á€”á€¹á€€á€¯á€”á€¹á€†á€­á€¯á€„á€¹ á€±á€¡á€¸á€™á€¼á€”á€¹', '', '2024-09-25 17:45:09', NULL, 0, '0000-00-00', NULL, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(104, 'carspa', '123', '2025-08-28 14:31:53', '', 'á€€á€­á€¯á€¸á€™á€­á€¯á€„á€¹POS', '', '2019-06-10 16:16:52', '2019-12-26 22:39:18', 0, '0000-00-00', NULL, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(105, 'fatfat-', '519888', '2024-03-09 15:46:17', '', 'afat old æ²’æœ‰ä»£è³¼åŠŸèƒ½', '', '2019-06-29 15:08:18', '2020-02-13 17:14:41', 0, '0000-00-00', NULL, NULL, NULL, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0, 2, 2, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 14, 0, 0, 0, 0, 0),
(107, 'ygnzawzaw', '022150', '2022-11-16 17:36:02', '', 'yá€±á€‡á€¬á€¹á€±á€‡á€¬á€¹  ygn', '', '2019-07-03 11:45:18', '2022-11-16 17:36:02', 1, '2022-11-01', NULL, NULL, NULL, 0, 10, 0, 0, 0, 0, 2, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 14, 0, 0, 0, 0, 14, 0, 0, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(106, 'laikuangchang', '61508210', '2025-08-28 02:19:20', '', 'laikuangchang', '', '2019-07-01 19:50:10', '2021-01-05 23:47:23', 0, '0000-00-00', NULL, NULL, NULL, 14, 14, 14, 0, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 14, 14, 14, 14, 14, 14, 0, 0, 0, 0, 0, 0, 30, 30, 30, 30, 30, 30, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 28, 28, 30, 0, 0, 0, 0, 0, 28, 14, 0, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 14, 14, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0),
(124, 'ygnzawmoekhant', '313318', '2025-08-28 12:33:08', '', 'ygnzawmoekhant', 'á€±á€‡á€¬á€¹á€™á€­á€¯á€¸á€á€”á€¹á‚•', '2022-11-16 17:41:58', '2024-07-01 18:52:14', 0, '0000-00-00', NULL, NULL, NULL, 0, 0, 0, 0, 0, 0, 2, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 6, 6, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(108, 'mdyayenandar', '123456', '2020-06-30 11:48:26', '', 'á€±á€¡á€¸á€”á‚áµá€¬ mdy', 'á€±á€¡á€¸á€”á‚áµá€¬', '2019-09-15 20:36:18', '2020-03-13 16:11:46', 0, '0000-00-00', NULL, NULL, NULL, 6, 0, 14, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 14, 0, 0, 6, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 14, 0, 0, 0, 12, 2, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 36, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 14, 0, 0, 0, 0, 0);
INSERT INTO `sys_loginsystem` (`sysloginID`, `loginID`, `password`, `time`, `pic`, `name`, `profile`, `create_time`, `update_time`, `expiration_chk`, `expiration_date`, `note_finance`, `note_deliver`, `note_purchase`, `power_product`, `power_product_sg`, `power_product_mm`, `power_member`, `power_memberRent`, `power_rent`, `power_finance`, `power_finance_s2t`, `power_finance_s2y`, `power_finance_t2s`, `power_finance_y2s`, `power_finance_y2t`, `power_finance_print_hint`, `power_finance_s2t_print_hint`, `power_finance_s2y_print_hint`, `power_finance_t2s_print_hint`, `power_finance_y2s_print_hint`, `power_finance_y2t_print_hint`, `power_finance_goods_reference`, `power_finance_s2t_goods_reference`, `power_finance_s2y_goods_reference`, `power_finance_t2s_goods_reference`, `power_finance_y2s_goods_reference`, `power_finance_y2t_goods_reference`, `power_finance_print_goods`, `power_finance_s2t_print_goods`, `power_finance_s2y_print_goods`, `power_finance_t2s_print_goods`, `power_finance_y2s_print_goods`, `power_finance_y2t_print_goods`, `power_new_deliver`, `power_new_deliver_s2t`, `power_new_deliver_s2y`, `power_new_deliver_t2s`, `power_new_deliver_y2s`, `power_new_deliver_y2t`, `power_deliver`, `power_deliverb2t`, `power_delivercarryb2t`, `power_delivercarryt2b`, `power_deliver_b2t`, `power_deliver_t2b`, `power_purchase`, `power_purchaseb2s`, `power_purchaseb2t`, `power_purchases2b`, `power_purchases2t`, `power_purchaset2s`, `power_purchase_print_hint`, `power_purchase_print_hint_b2s`, `power_purchase_print_hint_b2t`, `power_purchase_print_hint_s2b`, `power_purchase_print_hint_s2t`, `power_purchase_print_hint_t2s`, `power_download`, `power_system`, `power_login`, `power_member_singapore`, `power_member_myanmar`, `power_memberRent_singapore`, `power_memberRent_myanmar`, `power_in_out_singapore`, `power_in_out_myanmar`, `power_in_out`, `power_finance_setting`, `power_exchange_setting`, `power_income_text_setting`, `power_deliver_setting`, `power_feedback_setting`, `power_shopping`, `power_pos_sale_report`, `power_pos_sale_report_sg`, `power_pos_sale_report_mm`, `power_pos_expense`, `power_pos_expense_sg`, `power_pos_expense_mm`, `power_pos_member`, `power_pos_marquee`, `power_pos_marquee_sg`, `power_pos_marquee_mm`, `power_pos_cus_marquee`, `power_pos_cus_marquee_sg`, `power_pos_cus_marquee_mm`, `power_pos_store_income`, `power_pos_store_income_sg`, `power_pos_store_income_mm`, `power_pos_store_income_pim_in`, `power_pos_store_income_pim_out`, `power_staff`, `power_staff_modify`, `power_staff_salary_input`, `power_staff_print`, `power_finance_trans_tw`, `power_finance_trans_sg`, `power_finance_trans_mm`, `power_new_product_keyin`, `power_new_purchase_keyin`, `power_new_purchase_keyin_sg`, `power_new_purchase_keyin_mm`, `power_pos_sale_system`, `power_pos_sale_system_sg`, `power_pos_sale_system_mm`, `power_pos_rtn_system`, `power_pos_rtn_system_sg`, `power_pos_rtn_system_mm`, `power_poe`, `power_poe_country`, `power_poe_exchange`, `power_poe_bill_setting`, `power_poe_stock_report`, `power_poe_chat`, `power_poe_print`, `power_poe_admin`, `power_poe_chat_admin`, `power_poe_customer_type`, `power_ktv`, `power_ktv_sg`, `power_ktv_mm`, `power_pre_finance`, `power_pre_finance_s2t`, `power_pre_finance_s2y`, `power_pre_finance_t2s`, `power_pre_finance_y2s`, `power_pre_finance_y2t`, `power_pre_finance_from_tw`, `power_pre_finance_from_sg`, `power_pre_finance_from_mm`, `power_pre_finance_to_tw`, `power_pre_finance_to_sg`, `power_pre_finance_to_mm`, `power_pre_finance_approve`, `power_pre_finance_s2t_approve`, `power_pre_finance_s2y_approve`, `power_pre_finance_t2s_approve`, `power_pre_finance_y2s_approve`, `power_pre_finance_y2t_approve`, `power_pre_finance_from_tw_approve`, `power_pre_finance_from_sg_approve`, `power_pre_finance_from_mm_approve`, `power_pre_finance_to_tw_approve`, `power_pre_finance_to_sg_approve`, `power_pre_finance_to_mm_approve`, `power_pre_finance_print_hint`, `power_pre_finance_s2t_print_hint`, `power_pre_finance_s2y_print_hint`, `power_pre_finance_t2s_print_hint`, `power_pre_finance_y2s_print_hint`, `power_pre_finance_y2t_print_hint`, `power_pre_finance_from_tw_print_hint`, `power_pre_finance_from_sg_print_hint`, `power_pre_finance_from_mm_print_hint`, `power_pre_finance_to_tw_print_hint`, `power_pre_finance_to_sg_print_hint`, `power_pre_finance_to_mm_print_hint`, `power_pre_finance_print`, `power_pre_finance_s2t_print`, `power_pre_finance_s2y_print`, `power_pre_finance_t2s_print`, `power_pre_finance_y2s_print`, `power_pre_finance_y2t_print`, `power_pre_finance_from_tw_print`, `power_pre_finance_from_sg_print`, `power_pre_finance_from_mm_print`, `power_pre_finance_to_tw_print`, `power_pre_finance_to_sg_print`, `power_pre_finance_to_mm_print`, `power_mm_shopping`, `power_cal_tw`, `power_cal_sg`, `power_cal_mm`, `power_slide_show_tw`, `power_slide_show_sg`, `power_slide_show_mm`) VALUES
(109, 'ygncholaelaetun', '228630', '2021-11-07 14:51:15', '', 'YGN Cho Lae Lae Tun  á€á€ºá€­á€³á€œá€²á‚•á€œá€²á‚•á€‘á€¼á€”á€¹á€¸', '', '2019-09-20 19:26:29', '2020-01-07 02:07:12', 0, '0000-00-00', NULL, NULL, NULL, 0, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 14, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 0, 0, 6, 0, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 14, 0, 0, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 38, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(110, 'mdythanthan', '424260757', '2022-12-12 12:24:28', '', 'MDY á€žá€”á€¹á€¸á€žá€”á€¹á€¸á€»á€™á€­á€³á€„á€¹', 'MDY á€žá€”á€¹á€¸á€žá€”á€¹á€¸á€»á€™á€­á€³á€„á€¹', '2019-12-12 16:56:51', '2020-03-13 16:12:37', 0, '0000-00-00', NULL, NULL, NULL, 0, 0, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 14, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 0, 0, 14, 14, 0, 0, 14, 0, 0, 14, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 14, 0, 0, 0, 0, 2, 14, 0, 0, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(111, 'mdyhninhnin', '444689339', '2025-06-24 14:27:08', '', 'MDY á‚á€½á€„á€¹á€¸á‚á€½á€„á€¹á€¸', '', '2019-12-12 19:47:28', '2020-03-13 16:13:29', 0, '0000-00-00', NULL, NULL, NULL, 0, 0, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 14, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 0, 0, 6, 14, 0, 0, 14, 0, 0, 14, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 14, 0, 0, 0, 0, 2, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(112, 'mdymoemoe', '797471965', '2025-08-24 16:26:34', '', 'MDY á€á€„á€¹á€™á€­á€¯á€¸á€œá€á€¹', '', '2019-12-12 19:49:38', '2020-03-13 16:14:36', 0, '0000-00-00', NULL, NULL, NULL, 0, 0, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 14, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 0, 0, 6, 6, 0, 0, 14, 0, 0, 14, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 14, 0, 0, 0, 0, 2, 14, 0, 0, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(113, 'mdynandarmoe', '766564256', '2020-06-21 10:10:44', '', 'MDY á€”á‚áµá€¬á€™á€­á€¯á€¸', '', '2019-12-12 19:52:26', '2020-01-07 02:09:28', 0, '0000-00-00', NULL, NULL, NULL, 0, 0, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 14, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 14, 0, 0, 0, 0, 0, 14, 0, 0, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(114, 'mdyAyemyintmo', '212653', '2024-12-31 11:54:31', '', 'MDY á€±á€¡á€¸á€»á€™á€„á€¹á‚•á€™á€­á€¯', '', '2019-12-12 19:54:22', '2020-01-07 02:09:41', 0, '0000-00-00', NULL, NULL, NULL, 0, 0, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 14, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 14, 0, 0, 0, 0, 0, 14, 0, 0, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(115, 'mdyhtethtet', '440701582', '2025-08-26 15:03:43', '', 'MDYá€‘á€€á€¹á€‘á€€á€¹á€á€­á€¯á€„á€¹', '', '2019-12-13 17:20:56', '2022-07-09 14:05:42', 0, '0000-00-00', NULL, NULL, NULL, 0, 0, 14, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 14, 0, 0, 0, 0, 0, 0, 0, 14, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 14, 0, 0, 0, 14, 0, 14, 0, 0, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 46, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(119, 'ygnthineimon', '335566', '2024-07-31 11:07:43', '', 'ygn Â Â á€žá€„á€¹á€¸á€¡á€­á€™á€¼á€”á€¹', '', '2019-12-26 22:33:05', '2022-04-26 18:49:33', 0, '0000-00-00', NULL, NULL, NULL, 0, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 6, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 12, 0, 0, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(125, 'ygnnaingsuwai', '122447', '2025-08-28 17:44:22', '', 'á‚á€­á€¯á€„á€¹á€…á€¯á€±á€', '', '2023-02-28 21:35:31', '2025-08-07 21:48:58', 0, '0000-00-00', NULL, NULL, NULL, 0, 14, 14, 0, 0, 0, 2, 2, 6, 0, 6, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 4, 12, 12, 4, 4, 0, 0, 0, 0, 0, 0, 2, 6, 0, 6, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 14, 0, 0, 0, 0, 0, 6, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 0, 14, 0, 0, 0, 0, 14, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 34, 0, 36, 0, 38, 38, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(131, 'ygnkhantthunyein', '159197', '2025-08-28 17:24:41', '', 'á€á€”á€¹á‚•á€‘á€¼á€”á€¹á€¸', '', '2024-11-09 13:18:18', '2024-11-11 11:24:34', 0, '0000-00-00', NULL, NULL, NULL, 0, 0, 0, 0, 0, 0, 2, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(132, 'ygnthuzarwin', '201192', '2025-08-25 19:18:46', '', 'á€žá€°á€‡á€¬á€á€„á€¹á€¸', '', '2025-01-27 12:48:45', NULL, 0, '0000-00-00', NULL, NULL, NULL, 0, 0, 0, 0, 0, 0, 2, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 4, 4, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(133, 'dawnu', '123456', '2025-06-25 17:46:14', '', 'Daw Nu Singapore', '', '2025-03-07 11:56:03', '2025-06-25 17:45:35', 0, '0000-00-00', NULL, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 14, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 44, 0, 0, 0, 0, 0, 34, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(134, 'zawmyotun', 'zaw888516', '2025-07-27 18:34:19', '', 'zawmyotun', '', '2025-03-29 09:45:50', '2025-07-03 17:43:20', 0, '0000-00-00', NULL, NULL, NULL, 0, 0, 0, 0, 0, 0, 2, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 14, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 46, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- 資料表結構 `users`
--

CREATE TABLE `users` (
  `id` bigint UNSIGNED NOT NULL,
  `login_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '登入帳號',
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '密碼',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '姓名',
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '電子信箱',
  `pic` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '頭像路徑',
  `profile` text COLLATE utf8mb4_unicode_ci COMMENT '個人簡介',
  `status` enum('active','inactive','expired') COLLATE utf8mb4_unicode_ci DEFAULT 'active' COMMENT '帳號狀態',
  `expiration_date` date DEFAULT NULL COMMENT '到期日',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '建立時間',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新時間',
  `last_login_at` timestamp NULL DEFAULT NULL COMMENT '最後登入時間',
  `legacy_password` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `legacy_algo` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='使用者表';

--
-- 傾印資料表的資料 `users`
--

INSERT INTO `users` (`id`, `login_id`, `password`, `name`, `email`, `pic`, `profile`, `status`, `expiration_date`, `created_at`, `updated_at`, `last_login_at`, `legacy_password`, `legacy_algo`) VALUES
(12, 'jeffery', '$2y$12$vrQzCtSvL6F.PR8LWX9uAOvbb6p6aSQ5P2mvJzEh9yUC7LZHg4syO', 'tw ', NULL, '20130903125406.jpg', '', 'active', NULL, '2025-11-16 07:57:51', '2025-11-16 03:43:14', '2025-11-16 03:43:14', NULL, NULL),
(13, 'alex', 'alex123', '', NULL, '20130917122339.jpg', '', 'active', NULL, '2025-11-16 07:57:51', '2025-11-16 11:13:29', '2025-10-16 08:27:03', 'alex123', 'plain'),
(22, 'twmanthiri', '61508210', 'á€‘á€­á€¯á€„á€¹á€á€™á€¹á€†á€­á€¯á€„á€¹', NULL, '20130922070652.jpg', '', 'expired', '2014-10-04', '2025-11-16 07:57:51', '2025-11-16 11:13:29', '2019-07-01 11:51:11', '61508210', 'plain'),
(23, 'mac', '131064', 'tw', NULL, '', '', 'active', NULL, '2025-11-16 07:57:51', '2025-11-16 11:13:29', '2025-08-28 07:33:31', '131064', 'plain'),
(26, 'ygnkkt030', '115330', 'ygná€á€­á€¯á€„á€¹á€á€­á€¯á€„á€¹á€‘á€¼á€”á€¹á€¸', NULL, '20130915061132.jpg', '', 'active', NULL, '2025-11-16 07:57:51', '2025-11-16 11:13:29', '2025-08-28 10:28:57', '115330', 'plain'),
(27, 'maswe', '98626214', 'sgá€™á€±á€†á€¼', NULL, '', '', 'active', NULL, '2025-11-16 07:57:51', '2025-11-16 11:13:29', '2025-08-26 08:03:38', '98626214', 'plain'),
(28, 'htike', 'mtr21245', 'sgá€™á€±á€†á€¼', NULL, '20130916071207.jpg', '', 'active', '2015-06-03', '2025-11-16 07:57:51', '2025-11-16 11:13:29', '2025-08-20 17:16:19', 'mtr21245', 'plain'),
(32, 'ygnmawai', '105381', 'ygná€™á€±á€', NULL, '', '', 'active', NULL, '2025-11-16 07:57:51', '2025-11-16 11:13:29', '2025-08-27 01:53:45', '105381', 'plain'),
(33, 'ygnmaaye', '163693', 'ygná€™á€±á€¡á€¸', NULL, '', '', 'active', NULL, '2025-11-16 07:57:51', '2025-11-16 11:13:29', '2025-08-28 09:44:04', '163693', 'plain'),
(34, 'austin', 'austin', '', NULL, '', '', 'active', NULL, '2025-11-16 07:57:51', '2025-11-16 11:13:29', '2018-08-13 04:10:26', 'austin', 'plain'),
(35, 'mdymtr', '4034012', 'mdyá€™á€žá€¶', NULL, '', '', 'active', NULL, '2025-11-16 07:57:51', '2025-11-16 11:13:29', '2025-08-28 05:53:59', '4034012', 'plain'),
(42, 'maysukyi', '543479', 'á€±á€™á€…á€¯á¾á€€á€Šá€¹  ygn', NULL, '', '', 'active', '2018-12-01', '2025-11-16 07:57:51', '2025-11-16 11:13:29', '2025-08-28 09:47:16', '543479', 'plain'),
(43, 'ygnmtrttl', '5134353', 'á€‘á€¼á€”á€¹á€¸á€‘á€¼á€”á€¹á€¸á€œá€„á€¹á€¸  ygn', NULL, '', '', 'active', NULL, '2025-11-16 07:57:51', '2025-11-16 11:13:29', '2024-11-10 08:19:15', '5134353', 'plain'),
(46, 'ygnsoesoe', '281080', 'á€…á€­á€¯á€¸á€…á€­á€¯á€¸  ygn', NULL, '', '', 'active', NULL, '2025-11-16 07:57:51', '2025-11-16 11:13:29', '2024-11-07 08:15:08', '281080', 'plain'),
(47, 'ygnphonemincho', '145090', 'á€–á€¯á€”á€¹á€¸á€™á€„á€¹á€¸á€á€ºá€­á€³ ygn', NULL, '', '', 'active', NULL, '2025-11-16 07:57:51', '2025-11-16 11:13:29', '2025-08-10 06:31:10', '145090', 'plain'),
(51, 'mdytheingioo2010', '34012', 'á€žá€­á€‚á¤ á€®á€¦á€¸ mdy', NULL, '', '', 'active', NULL, '2025-11-16 07:57:51', '2025-11-16 11:13:29', '2025-08-04 07:27:28', '34012', 'plain'),
(54, 'ailin', 'ailin', 'tw á€€á€ºá€¶á€³á€¸á€œá€­', NULL, '', '', 'active', NULL, '2025-11-16 07:57:51', '2025-11-16 11:13:29', '2025-08-28 10:03:05', 'ailin', 'plain'),
(55, 'ygnmaythinzarnu', '063925', 'ygn á€±á€™á€žá€°á€‡á€¬á‚á€¯', NULL, '', '', 'active', NULL, '2025-11-16 07:57:51', '2025-11-16 11:13:29', '2025-07-30 06:33:01', '063925', 'plain'),
(56, 'mdymamin', '332525', 'á€™á€™á€„á€¹á€¸ mdy', NULL, '', '', 'active', NULL, '2025-11-16 07:57:51', '2025-11-16 11:13:29', '2025-08-28 04:30:21', '332525', 'plain'),
(57, 'ygnyannaing', '235678', 'ygn á€›á€”á€¹á‚á€­á€¯á€„á€¹á€…á€­á€¯á€¸', NULL, '', '', 'active', '2015-12-01', '2025-11-16 07:57:51', '2025-11-16 11:13:29', '2025-08-25 06:47:54', '235678', 'plain'),
(60, 'ygnthwethwe', '181118', 'á€žá€¼á€šá€¹á€žá€¼á€šá€¹ ygn', NULL, '', '', 'active', NULL, '2025-11-16 07:57:51', '2025-11-16 11:13:29', '2025-08-25 07:23:01', '181118', 'plain'),
(62, 'mdycounter', '240613', 'á€™á€”á€¹á€¸á€±á€œá€¸ á€™á€”á€¹á€¸á€”á€®á€¸á€á€ºá€­á€”á€¹á€‚á€ºá€¬ mdy', NULL, '', '', 'active', NULL, '2025-11-16 07:57:51', '2025-11-16 11:13:29', '2020-10-23 02:19:12', '240613', 'plain'),
(63, 'ygnMT', '201272', 'á€™á€™á€­á€¯á€¸á€žá€® ygn', NULL, '', '', 'active', NULL, '2025-11-16 07:57:51', '2025-11-16 11:13:29', '2025-07-23 07:13:23', '201272', 'plain'),
(65, 'wuga', '1116', 'tw', NULL, '', '', 'active', NULL, '2025-11-16 07:57:51', '2025-11-16 11:13:29', '2024-11-27 05:25:40', '1116', 'plain'),
(66, 's9156112', 's9156112', 'twá€¡á€á€®á€¸', NULL, '', '', 'active', NULL, '2025-11-16 07:57:51', '2025-11-16 11:13:29', '2025-08-28 05:17:00', 's9156112', 'plain'),
(67, 'Linkin', '200811', 'tw', NULL, '', '', 'active', NULL, '2025-11-16 07:57:51', '2025-11-16 11:13:29', '2025-08-11 01:58:40', '200811', 'plain'),
(68, 'ashang', '131910', 'tw é˜¿é¦™ á€¡á€¬á€¸á€›á€½á€”á€¹á€¸', NULL, '', '', 'active', NULL, '2025-11-16 07:57:51', '2025-11-16 11:13:29', '2025-08-24 01:13:44', '131910', 'plain'),
(69, 'fatfat', '519888', 'tw é˜¿ç™¼ á€¡á€–á€á€¹ afat', NULL, '', '', 'active', NULL, '2025-11-16 07:57:51', '2025-11-16 11:13:29', '2025-08-28 09:24:40', '519888', 'plain'),
(73, 'mama', '1954', 'twá€™á€¬á€™á€¬á€¸', NULL, '', '', 'active', NULL, '2025-11-16 07:57:51', '2025-11-16 11:13:29', '2025-08-28 09:26:26', '1954', 'plain'),
(74, 'ygnsusuwin', '202088', 'á€™á€…á€¯á€…á€¯á€á€„á€¹á€¸ ygn', NULL, '', '', 'expired', '2023-09-01', '2025-11-16 07:57:51', '2025-11-16 11:13:29', '2023-09-12 05:28:21', '202088', 'plain'),
(76, 'kevin', '1234', 'å ±é—œè¡ŒKEVIN', NULL, '', '', 'active', NULL, '2014-09-30 07:36:37', '2025-11-16 11:13:29', '2015-07-21 07:12:32', '1234', 'plain'),
(78, 'zarzar', '123123', 'sgá€…á€€á¤á€¬á€•á€° ', NULL, '', '', 'active', '2018-01-16', '2014-12-07 08:14:33', '2025-11-16 11:13:29', '2018-11-01 12:53:05', '123123', 'plain'),
(80, 'ygnhtetwaiyansoe', '139783', 'ygná€‘á€€á€¹á€±á€á€šá€¶á€…á€­á€¯á€¸ / á€›á€”á€¹á€€á€¯á€”á€¹á€›á€¶á€¯á€¸', NULL, '', '', 'active', NULL, '2015-01-20 06:49:30', '2025-11-16 11:13:29', '2025-08-25 10:47:56', '139783', 'plain'),
(81, 'htetlinaung', '693126', 'á€‘á€€á€¹á€œá€„á€¹á€¸á€±á€¡á€¬á€„á€¹   ygn ', NULL, '', '', 'active', '2018-12-01', '2015-03-17 09:44:49', '2025-11-16 11:13:29', '2025-08-28 03:19:45', '693126', 'plain'),
(82, 'ygnshunshun', '259046937', 'á€›á€¼á€”á€¹á€¸á€œá€½á€²á‚•á€á€„á€¹á€¸  ygn', NULL, '', '', 'expired', '2020-03-19', '2015-05-18 09:52:53', '2025-11-16 11:13:29', '2020-03-20 07:19:06', '259046937', 'plain'),
(84, 'ygnshwezin', '402780466', 'á€±á€›á‚Šá€‡á€„á€¹ ygn á€±á€›á‚Šá€…á€„á€¹', NULL, '', '', 'active', NULL, '2015-05-18 09:55:04', '2025-11-16 11:13:29', '2025-08-28 10:28:00', '402780466', 'plain'),
(85, 'henrykengemma', 'henry199', 'twé˜¿å®', NULL, '', '', 'active', NULL, '2015-11-06 08:39:30', '2025-11-16 11:13:29', '2025-08-28 05:35:37', 'henry199', 'plain'),
(87, 'manwe', '123', 'á€™á‚á€¼á€šá€¹ sg', NULL, '', '', 'active', '2020-04-01', '2015-12-06 17:46:04', '2025-11-16 11:13:29', '2020-06-11 05:23:17', '123', 'plain'),
(89, 'aiden', '0289230683', 'é˜¿æ˜‡ aiden', NULL, '', '', 'active', NULL, '2016-06-14 01:50:51', '2025-11-16 11:13:29', '2025-08-26 13:30:25', '0289230683', 'plain'),
(91, 'ygnhayman', '81166', 'á€±á€Ÿá€™á€”á€¹á€™á€ºá€­á€³á€¸ygn', NULL, '', 'á€±á€Ÿá€™á€”á€¹á€™á€ºá€­á€³á€¸', 'expired', '2020-03-19', '2016-08-30 09:57:19', '2025-11-16 11:13:29', '2020-03-20 07:20:12', '81166', 'plain'),
(92, 'ygnkaunghtetmoe', '138423', 'á€›á€”á€¹á€€á€¯á€”á€¹ á€±á€€á€¬á€„á€¹á€¸á€‘á€€á€¹á€™á€­á€¯á€¸', NULL, '', '', 'active', '2022-11-01', '2017-02-01 16:14:26', '2025-11-16 11:13:29', '2025-08-28 03:58:53', '138423', 'plain'),
(93, 'mdyayethan', '123456', 'MDY á€™á€±á€¡á€¸á€žá€”á€¹á€¸', NULL, '', '', 'active', NULL, '2018-05-21 06:57:44', '2025-11-16 11:13:29', '2020-07-28 09:41:56', '123456', 'plain'),
(94, 'ygnthetnaingsoe', '155621', 'ygn á€žá€€á€¹á€”á€­á€„á€¹á€…á€­á€¯á€¸', NULL, '', '', 'active', NULL, '2018-11-21 01:23:04', '2025-11-16 11:13:29', '2023-07-20 09:33:53', '155621', 'plain'),
(96, 'ygnnyomee', '199721', 'ygn á€Šá€­á€³á€™á€®á€œá€­á‚ˆá€„á€¹', NULL, '', '', 'active', NULL, '2018-11-23 03:25:35', '2025-11-16 11:13:29', '2025-08-28 06:41:42', '199721', 'plain'),
(97, 'ygnhtwehtwe', '252525', 'ygn shop á€žá€”á€¹á€¸á€žá€”á€¹á€¸á€±á€‘á€¼á€¸', NULL, '', '', 'expired', '2021-01-08', '2018-11-23 08:14:16', '2025-11-16 11:13:29', '2021-01-18 06:03:58', '252525', 'plain'),
(98, 'yamin', '427633455', 'á€€á€­á€¯á€¸á€™á€­á€¯á€„á€¹  á€šá€™á€„á€¹á€¸', NULL, '', '', 'active', NULL, '2019-02-22 07:05:11', '2025-11-16 11:13:29', '2024-03-19 12:34:16', '427633455', 'plain'),
(99, 'ygnAyeChanMoe', '110512', 'ygn á€±á€¡á€¸á€á€ºá€™á€¹á€¸á€™á€­á€¯á€¸', NULL, '', '', 'active', NULL, '2019-04-07 07:28:58', '2025-11-16 11:13:29', '2025-08-28 09:41:59', '110512', 'plain'),
(100, 'moezawoo', '79741590', 'Car spa moe zaw oo', NULL, '', 'á€™á€­á€¯á€¸á€±á€‡á€¬á€¹á€¦á€¸', 'active', NULL, '2019-06-05 05:52:16', '2025-11-16 11:13:29', '2019-06-05 05:52:16', '79741590', 'plain'),
(104, 'carspa', '123', 'á€€á€­á€¯á€¸á€™á€­á€¯á€„á€¹POS', NULL, '', '', 'active', NULL, '2019-06-10 08:16:52', '2025-11-16 11:13:29', '2025-08-28 06:31:53', '123', 'plain'),
(105, 'fatfat-', '519888', 'afat old æ²’æœ‰ä»£è³¼åŠŸèƒ½', NULL, '', '', 'active', NULL, '2019-06-29 07:08:18', '2025-11-16 11:13:29', '2024-03-09 07:46:17', '519888', 'plain'),
(106, 'laikuangchang', '61508210', 'laikuangchang', NULL, '', '', 'active', NULL, '2019-07-01 11:50:10', '2025-11-16 11:13:29', '2025-08-27 18:19:20', '61508210', 'plain'),
(107, 'ygnzawzaw', '022150', 'yá€±á€‡á€¬á€¹á€±á€‡á€¬á€¹  ygn', NULL, '', '', 'expired', '2022-11-01', '2019-07-03 03:45:18', '2025-11-16 11:13:29', '2022-11-16 09:36:02', '022150', 'plain'),
(108, 'mdyayenandar', '123456', 'á€±á€¡á€¸á€”á‚áµá€¬ mdy', NULL, '', 'á€±á€¡á€¸á€”á‚áµá€¬', 'active', NULL, '2019-09-15 12:36:18', '2025-11-16 11:13:29', '2020-06-30 03:48:26', '123456', 'plain'),
(109, 'ygncholaelaetun', '228630', 'YGN Cho Lae Lae Tun  á€á€ºá€­á€³á€œá€²á‚•á€œá€²á‚•á€‘á€¼á€”á€¹á€¸', NULL, '', '', 'active', NULL, '2019-09-20 11:26:29', '2025-11-16 11:13:29', '2021-11-07 06:51:15', '228630', 'plain'),
(110, 'mdythanthan', '424260757', 'MDY á€žá€”á€¹á€¸á€žá€”á€¹á€¸á€»á€™á€­á€³á€„á€¹', NULL, '', 'MDY á€žá€”á€¹á€¸á€žá€”á€¹á€¸á€»á€™á€­á€³á€„á€¹', 'active', NULL, '2019-12-12 08:56:51', '2025-11-16 11:13:29', '2022-12-12 04:24:28', '424260757', 'plain'),
(111, 'mdyhninhnin', '444689339', 'MDY á‚á€½á€„á€¹á€¸á‚á€½á€„á€¹á€¸', NULL, '', '', 'active', NULL, '2019-12-12 11:47:28', '2025-11-16 11:13:29', '2025-06-24 06:27:08', '444689339', 'plain'),
(112, 'mdymoemoe', '797471965', 'MDY á€á€„á€¹á€™á€­á€¯á€¸á€œá€á€¹', NULL, '', '', 'active', NULL, '2019-12-12 11:49:38', '2025-11-16 11:13:29', '2025-08-24 08:26:34', '797471965', 'plain'),
(113, 'mdynandarmoe', '766564256', 'MDY á€”á‚áµá€¬á€™á€­á€¯á€¸', NULL, '', '', 'active', NULL, '2019-12-12 11:52:26', '2025-11-16 11:13:29', '2020-06-21 02:10:44', '766564256', 'plain'),
(114, 'mdyAyemyintmo', '212653', 'MDY á€±á€¡á€¸á€»á€™á€„á€¹á‚•á€™á€­á€¯', NULL, '', '', 'active', NULL, '2019-12-12 11:54:22', '2025-11-16 11:13:29', '2024-12-31 03:54:31', '212653', 'plain'),
(115, 'mdyhtethtet', '440701582', 'MDYá€‘á€€á€¹á€‘á€€á€¹á€á€­á€¯á€„á€¹', NULL, '', '', 'active', NULL, '2019-12-13 09:20:56', '2025-11-16 11:13:29', '2025-08-26 07:03:43', '440701582', 'plain'),
(119, 'ygnthineimon', '335566', 'ygn Â Â á€žá€„á€¹á€¸á€¡á€­á€™á€¼á€”á€¹', NULL, '', '', 'active', NULL, '2019-12-26 14:33:05', '2025-11-16 11:13:29', '2024-07-31 03:07:43', '335566', 'plain'),
(120, 'allen', '123456', 'é˜¿è€€', NULL, '', '', 'active', NULL, '2020-05-23 09:34:02', '2025-11-16 11:13:29', '2025-08-17 13:04:09', '123456', 'plain'),
(122, 'ygnsoemarlwin', '127408', 'á€™ á€±á€œá€¸á€…á€­á€¯á€¸á€™á€¬á€œá€¼á€„á€¹', NULL, '', 'á€™ á€±á€œá€¸á€…á€­á€¯á€¸á€™á€¬á€œá€¼á€„á€¹', 'active', NULL, '2022-11-16 09:39:26', '2025-11-16 11:13:29', '2025-08-28 10:22:34', '127408', 'plain'),
(123, 'ygnzawmyohtwe', '111111', 'ygnzawmyohtwe', NULL, '', 'á€±á€‡á€¬á€¹á€™á€­á€¯á€¸á€±á€‘á€¼á€¸', 'active', NULL, '2022-11-16 09:40:49', '2025-11-16 11:13:29', '2025-08-11 11:22:23', '111111', 'plain'),
(124, 'ygnzawmoekhant', '313318', 'ygnzawmoekhant', NULL, '', 'á€±á€‡á€¬á€¹á€™á€­á€¯á€¸á€á€”á€¹á‚•', 'active', NULL, '2022-11-16 09:41:58', '2025-11-16 11:13:29', '2025-08-28 04:33:08', '313318', 'plain'),
(125, 'ygnnaingsuwai', '122447', 'á‚á€­á€¯á€„á€¹á€…á€¯á€±á€', NULL, '', '', 'active', NULL, '2023-02-28 13:35:31', '2025-11-16 11:13:29', '2025-08-28 09:44:22', '122447', 'plain'),
(126, 'mp3', 'mp3', 'for customer', NULL, '', '', 'expired', '2024-09-10', '2023-08-26 09:23:03', '2025-11-16 11:13:29', '2023-08-26 09:48:53', 'mp3', 'plain'),
(127, 'aungmyintmyat', 'aung1224', 'Aung Myint Myat', NULL, '', '', 'active', NULL, '2024-03-24 01:45:47', '2025-11-16 11:13:29', '2025-07-10 09:02:12', 'aung1224', 'plain'),
(128, 'ygnhlayaminoo', '212199', 'á€šá€™á€„á€¹á€¸', NULL, '', '', 'active', NULL, '2024-09-25 08:46:02', '2025-11-16 11:13:29', '2025-08-28 07:26:56', '212199', 'plain'),
(129, 'ygnayemon', '105968', 'á€›á€”á€¹á€€á€¯á€”á€¹á€†á€­á€¯á€„á€¹ á€±á€¡á€¸á€™á€¼á€”á€¹', NULL, '', '', 'active', NULL, '2024-09-25 09:45:09', '2025-11-16 11:13:29', '2025-08-19 10:45:25', '105968', 'plain'),
(130, 'ygnkhantkhaaung', '230414', 'á€›á€”á€¹á€€á€¯á€”á€¹á€†á€¯á€­á€„á€¹ á€á€”á€¹á‚•á€á€±á€¡á€¬á€„á€¹', NULL, '', '', 'active', NULL, '2024-09-25 09:46:20', '2025-11-16 11:13:29', '2024-10-29 07:04:31', '230414', 'plain'),
(131, 'ygnkhantthunyein', '159197', 'á€á€”á€¹á‚•á€‘á€¼á€”á€¹á€¸', NULL, '', '', 'active', NULL, '2024-11-09 05:18:18', '2025-11-16 11:13:29', '2025-08-28 09:24:41', '159197', 'plain'),
(132, 'ygnthuzarwin', '201192', 'á€žá€°á€‡á€¬á€á€„á€¹á€¸', NULL, '', '', 'active', NULL, '2025-01-27 04:48:45', '2025-11-16 11:13:29', '2025-08-25 11:18:46', '201192', 'plain'),
(133, 'dawnu', '123456', 'Daw Nu Singapore', NULL, '', '', 'active', NULL, '2025-03-07 03:56:03', '2025-11-16 11:13:29', '2025-06-25 09:46:14', '123456', 'plain'),
(134, 'zawmyotun', 'zaw888516', 'zawmyotun', NULL, '', '', 'active', NULL, '2025-03-29 01:45:50', '2025-11-16 11:13:29', '2025-07-27 10:34:19', 'zaw888516', 'plain');

-- --------------------------------------------------------

--
-- 資料表結構 `user_notes`
--

CREATE TABLE `user_notes` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL COMMENT '使用者ID',
  `note_type` enum('finance','deliver','purchase') COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '備註類型',
  `content` longtext COLLATE utf8mb4_unicode_ci COMMENT '備註內容',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='使用者備註表';

--
-- 傾印資料表的資料 `user_notes`
--

INSERT INTO `user_notes` (`id`, `user_id`, `note_type`, `content`, `updated_at`) VALUES
(1, 12, 'finance', 'å¯„æ¬¾æ³¨æ„äº‹é … 1\r\nå¯„æ¬¾æ³¨æ„äº‹é … 2\r\nå¯„æ¬¾æ³¨æ„äº‹é … 3\r\nå¯„æ¬¾æ³¨æ„äº‹é … 4\r\nå¯„æ¬¾æ³¨æ„äº‹é … 5', '2025-05-08 11:50:29'),
(2, 12, 'deliver', 'å¯„è²¨æ³¨æ„äº‹é … 1\r\nå¯„è²¨æ³¨æ„äº‹é … 2\r\nå¯„è²¨æ³¨æ„äº‹é … 3\r\nå¯„è²¨æ³¨æ„äº‹é … 4\r\nå¯„è²¨æ³¨æ„äº‹é … 5', '2025-05-08 11:50:29'),
(3, 12, 'purchase', 'è¨‚å–®æ³¨æ„äº‹é … 1\r\nè¨‚å–®æ³¨æ„äº‹é … 2\r\nè¨‚å–®æ³¨æ„äº‹é … 3\r\nè¨‚å–®æ³¨æ„äº‹é … 4\r\nè¨‚å–®æ³¨æ„äº‹é … 5\r\nè¨‚å–®æ³¨æ„äº‹é … 6\r\nè¨‚å–®æ³¨æ„äº‹é … 7', '2025-05-08 11:50:29');

-- --------------------------------------------------------

--
-- 資料表結構 `user_permissions`
--

CREATE TABLE `user_permissions` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL COMMENT '使用者ID',
  `permission_id` int UNSIGNED NOT NULL COMMENT '權限ID',
  `is_granted` tinyint(1) DEFAULT '1' COMMENT '是否授予 (1=授予, 0=撤銷覆蓋角色權限)',
  `granted_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '授權時間',
  `granted_by` bigint UNSIGNED DEFAULT NULL COMMENT '授權者ID'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='使用者-權限關聯表 (直接授權)';

--
-- 傾印資料表的資料 `user_permissions`
--

INSERT INTO `user_permissions` (`id`, `user_id`, `permission_id`, `is_granted`, `granted_at`, `granted_by`) VALUES
(1, 12, 27, 1, '2025-11-16 10:04:55', NULL),
(2, 12, 30, 1, '2025-11-16 10:04:55', NULL),
(3, 12, 25, 1, '2025-11-16 10:04:55', NULL),
(4, 12, 16, 1, '2025-11-16 10:04:55', NULL),
(5, 12, 17, 1, '2025-11-16 10:04:55', NULL),
(6, 12, 21, 1, '2025-11-16 10:04:55', NULL),
(7, 12, 20, 1, '2025-11-16 10:04:55', NULL),
(8, 12, 15, 1, '2025-11-16 10:04:55', NULL),
(9, 12, 8, 1, '2025-11-16 10:04:55', NULL),
(10, 12, 9, 1, '2025-11-16 10:04:55', NULL),
(11, 12, 13, 1, '2025-11-16 10:04:55', NULL),
(12, 12, 12, 1, '2025-11-16 10:04:55', NULL),
(13, 12, 7, 1, '2025-11-16 10:04:55', NULL),
(14, 12, 1, 1, '2025-11-16 10:04:55', NULL),
(15, 12, 6, 1, '2025-11-16 10:04:55', NULL),
(16, 13, 27, 1, '2025-11-16 10:04:55', NULL),
(17, 13, 30, 1, '2025-11-16 10:04:55', NULL),
(18, 13, 25, 1, '2025-11-16 10:04:55', NULL),
(19, 13, 16, 1, '2025-11-16 10:04:55', NULL),
(20, 13, 17, 1, '2025-11-16 10:04:55', NULL),
(21, 13, 21, 1, '2025-11-16 10:04:55', NULL),
(22, 13, 20, 1, '2025-11-16 10:04:55', NULL),
(23, 13, 15, 1, '2025-11-16 10:04:55', NULL),
(24, 13, 8, 1, '2025-11-16 10:04:55', NULL),
(25, 13, 9, 1, '2025-11-16 10:04:55', NULL),
(26, 13, 13, 1, '2025-11-16 10:04:55', NULL),
(27, 13, 12, 1, '2025-11-16 10:04:55', NULL),
(28, 13, 7, 1, '2025-11-16 10:04:55', NULL),
(29, 13, 1, 1, '2025-11-16 10:04:55', NULL),
(31, 22, 27, 1, '2025-11-16 10:04:55', NULL),
(32, 22, 30, 1, '2025-11-16 10:04:55', NULL),
(33, 22, 25, 1, '2025-11-16 10:04:55', NULL),
(34, 22, 16, 1, '2025-11-16 10:04:55', NULL),
(35, 22, 17, 1, '2025-11-16 10:04:55', NULL),
(36, 22, 21, 1, '2025-11-16 10:04:55', NULL),
(37, 22, 20, 1, '2025-11-16 10:04:55', NULL),
(38, 22, 15, 1, '2025-11-16 10:04:55', NULL),
(39, 22, 8, 1, '2025-11-16 10:04:55', NULL),
(40, 22, 9, 1, '2025-11-16 10:04:55', NULL),
(41, 22, 13, 1, '2025-11-16 10:04:55', NULL),
(42, 22, 12, 1, '2025-11-16 10:04:55', NULL),
(43, 22, 7, 1, '2025-11-16 10:04:55', NULL),
(44, 22, 1, 1, '2025-11-16 10:04:55', NULL),
(45, 22, 6, 1, '2025-11-16 10:04:55', NULL),
(46, 23, 27, 1, '2025-11-16 10:04:55', NULL),
(47, 23, 30, 1, '2025-11-16 10:04:55', NULL),
(48, 23, 25, 1, '2025-11-16 10:04:55', NULL),
(49, 23, 17, 1, '2025-11-16 10:04:55', NULL),
(50, 23, 15, 1, '2025-11-16 10:04:55', NULL),
(51, 23, 8, 1, '2025-11-16 10:04:55', NULL),
(52, 23, 9, 1, '2025-11-16 10:04:55', NULL),
(53, 23, 7, 1, '2025-11-16 10:04:55', NULL),
(54, 23, 1, 1, '2025-11-16 10:04:55', NULL),
(55, 23, 6, 1, '2025-11-16 10:04:55', NULL),
(61, 26, 27, 1, '2025-11-16 10:04:55', NULL),
(62, 26, 30, 1, '2025-11-16 10:04:55', NULL),
(63, 26, 25, 1, '2025-11-16 10:04:55', NULL),
(64, 26, 21, 1, '2025-11-16 10:04:55', NULL),
(65, 26, 20, 1, '2025-11-16 10:04:55', NULL),
(66, 26, 15, 1, '2025-11-16 10:04:55', NULL),
(67, 26, 8, 1, '2025-11-16 10:04:55', NULL),
(68, 26, 9, 1, '2025-11-16 10:04:55', NULL),
(69, 26, 13, 1, '2025-11-16 10:04:55', NULL),
(70, 26, 12, 1, '2025-11-16 10:04:55', NULL),
(71, 26, 7, 1, '2025-11-16 10:04:55', NULL),
(72, 26, 1, 1, '2025-11-16 10:04:55', NULL),
(73, 26, 6, 1, '2025-11-16 10:04:55', NULL),
(76, 27, 30, 1, '2025-11-16 10:04:55', NULL),
(77, 27, 21, 1, '2025-11-16 10:04:55', NULL),
(78, 27, 20, 1, '2025-11-16 10:04:55', NULL),
(79, 27, 15, 1, '2025-11-16 10:04:55', NULL),
(80, 27, 13, 1, '2025-11-16 10:04:55', NULL),
(81, 27, 12, 1, '2025-11-16 10:04:55', NULL),
(82, 27, 7, 1, '2025-11-16 10:04:55', NULL),
(83, 27, 1, 1, '2025-11-16 10:04:55', NULL),
(84, 27, 6, 1, '2025-11-16 10:04:55', NULL),
(91, 28, 21, 1, '2025-11-16 10:04:55', NULL),
(92, 28, 20, 1, '2025-11-16 10:04:55', NULL),
(93, 28, 15, 1, '2025-11-16 10:04:55', NULL),
(94, 28, 13, 1, '2025-11-16 10:04:55', NULL),
(95, 28, 12, 1, '2025-11-16 10:04:55', NULL),
(96, 28, 7, 1, '2025-11-16 10:04:55', NULL),
(97, 28, 1, 1, '2025-11-16 10:04:55', NULL),
(98, 28, 6, 1, '2025-11-16 10:04:55', NULL),
(106, 32, 30, 1, '2025-11-16 10:04:55', NULL),
(107, 32, 13, 1, '2025-11-16 10:04:55', NULL),
(108, 32, 12, 1, '2025-11-16 10:04:55', NULL),
(109, 32, 7, 1, '2025-11-16 10:04:55', NULL),
(113, 33, 20, 1, '2025-11-16 10:04:55', NULL),
(114, 33, 12, 1, '2025-11-16 10:04:55', NULL),
(115, 33, 6, 1, '2025-11-16 10:04:55', NULL),
(116, 34, 30, 1, '2025-11-16 10:04:55', NULL),
(117, 34, 25, 1, '2025-11-16 10:04:55', NULL),
(118, 34, 17, 1, '2025-11-16 10:04:55', NULL),
(119, 34, 21, 1, '2025-11-16 10:04:55', NULL),
(120, 34, 20, 1, '2025-11-16 10:04:55', NULL),
(121, 34, 15, 1, '2025-11-16 10:04:55', NULL),
(122, 34, 9, 1, '2025-11-16 10:04:55', NULL),
(123, 34, 13, 1, '2025-11-16 10:04:55', NULL),
(124, 34, 12, 1, '2025-11-16 10:04:55', NULL),
(125, 34, 7, 1, '2025-11-16 10:04:55', NULL),
(126, 34, 1, 1, '2025-11-16 10:04:55', NULL),
(127, 34, 6, 1, '2025-11-16 10:04:55', NULL),
(131, 35, 27, 1, '2025-11-16 10:04:55', NULL),
(132, 35, 25, 1, '2025-11-16 10:04:55', NULL),
(133, 35, 21, 1, '2025-11-16 10:04:55', NULL),
(134, 35, 13, 1, '2025-11-16 10:04:55', NULL),
(138, 42, 30, 1, '2025-11-16 10:04:55', NULL),
(139, 42, 12, 1, '2025-11-16 10:04:55', NULL),
(141, 43, 27, 1, '2025-11-16 10:04:55', NULL),
(142, 43, 25, 1, '2025-11-16 10:04:55', NULL),
(144, 46, 27, 1, '2025-11-16 10:04:55', NULL),
(145, 46, 25, 1, '2025-11-16 10:04:55', NULL),
(147, 47, 27, 1, '2025-11-16 10:04:55', NULL),
(148, 47, 25, 1, '2025-11-16 10:04:55', NULL),
(149, 47, 9, 1, '2025-11-16 10:04:55', NULL),
(150, 47, 12, 1, '2025-11-16 10:04:55', NULL),
(151, 47, 7, 1, '2025-11-16 10:04:55', NULL),
(154, 51, 13, 1, '2025-11-16 10:04:55', NULL),
(155, 54, 27, 1, '2025-11-16 10:04:55', NULL),
(156, 54, 25, 1, '2025-11-16 10:04:55', NULL),
(157, 54, 9, 1, '2025-11-16 10:04:55', NULL),
(158, 54, 7, 1, '2025-11-16 10:04:55', NULL),
(162, 55, 27, 1, '2025-11-16 10:04:55', NULL),
(163, 55, 25, 1, '2025-11-16 10:04:55', NULL),
(164, 55, 8, 1, '2025-11-16 10:04:55', NULL),
(165, 55, 9, 1, '2025-11-16 10:04:55', NULL),
(166, 55, 13, 1, '2025-11-16 10:04:55', NULL),
(167, 55, 12, 1, '2025-11-16 10:04:55', NULL),
(168, 55, 7, 1, '2025-11-16 10:04:55', NULL),
(169, 56, 27, 1, '2025-11-16 10:04:55', NULL),
(170, 56, 25, 1, '2025-11-16 10:04:55', NULL),
(171, 56, 13, 1, '2025-11-16 10:04:55', NULL),
(172, 57, 27, 1, '2025-11-16 10:04:55', NULL),
(173, 57, 25, 1, '2025-11-16 10:04:55', NULL),
(175, 60, 12, 1, '2025-11-16 10:04:55', NULL),
(176, 63, 27, 1, '2025-11-16 10:04:55', NULL),
(177, 63, 30, 1, '2025-11-16 10:04:55', NULL),
(178, 63, 25, 1, '2025-11-16 10:04:55', NULL),
(179, 63, 9, 1, '2025-11-16 10:04:55', NULL),
(180, 63, 7, 1, '2025-11-16 10:04:55', NULL),
(183, 65, 27, 1, '2025-11-16 10:04:55', NULL),
(184, 65, 30, 1, '2025-11-16 10:04:55', NULL),
(185, 65, 25, 1, '2025-11-16 10:04:55', NULL),
(186, 65, 16, 1, '2025-11-16 10:04:55', NULL),
(187, 65, 17, 1, '2025-11-16 10:04:55', NULL),
(188, 65, 15, 1, '2025-11-16 10:04:55', NULL),
(189, 65, 8, 1, '2025-11-16 10:04:55', NULL),
(190, 65, 9, 1, '2025-11-16 10:04:55', NULL),
(191, 65, 7, 1, '2025-11-16 10:04:55', NULL),
(198, 66, 27, 1, '2025-11-16 10:04:55', NULL),
(199, 66, 30, 1, '2025-11-16 10:04:55', NULL),
(200, 66, 25, 1, '2025-11-16 10:04:55', NULL),
(201, 66, 16, 1, '2025-11-16 10:04:55', NULL),
(202, 66, 17, 1, '2025-11-16 10:04:55', NULL),
(203, 66, 21, 1, '2025-11-16 10:04:55', NULL),
(204, 66, 20, 1, '2025-11-16 10:04:55', NULL),
(205, 66, 15, 1, '2025-11-16 10:04:55', NULL),
(206, 66, 8, 1, '2025-11-16 10:04:55', NULL),
(207, 66, 9, 1, '2025-11-16 10:04:55', NULL),
(208, 66, 13, 1, '2025-11-16 10:04:55', NULL),
(209, 66, 7, 1, '2025-11-16 10:04:55', NULL),
(213, 67, 27, 1, '2025-11-16 10:04:55', NULL),
(214, 67, 25, 1, '2025-11-16 10:04:55', NULL),
(215, 67, 16, 1, '2025-11-16 10:04:55', NULL),
(216, 67, 17, 1, '2025-11-16 10:04:55', NULL),
(217, 67, 15, 1, '2025-11-16 10:04:55', NULL),
(218, 67, 8, 1, '2025-11-16 10:04:55', NULL),
(219, 67, 9, 1, '2025-11-16 10:04:55', NULL),
(220, 67, 7, 1, '2025-11-16 10:04:55', NULL),
(228, 68, 27, 1, '2025-11-16 10:04:55', NULL),
(229, 68, 30, 1, '2025-11-16 10:04:55', NULL),
(230, 68, 25, 1, '2025-11-16 10:04:55', NULL),
(231, 68, 16, 1, '2025-11-16 10:04:55', NULL),
(232, 68, 17, 1, '2025-11-16 10:04:55', NULL),
(233, 68, 21, 1, '2025-11-16 10:04:55', NULL),
(234, 68, 20, 1, '2025-11-16 10:04:55', NULL),
(235, 68, 15, 1, '2025-11-16 10:04:55', NULL),
(236, 68, 8, 1, '2025-11-16 10:04:55', NULL),
(237, 68, 9, 1, '2025-11-16 10:04:55', NULL),
(238, 68, 12, 1, '2025-11-16 10:04:55', NULL),
(239, 68, 7, 1, '2025-11-16 10:04:55', NULL),
(243, 69, 27, 1, '2025-11-16 10:04:55', NULL),
(244, 69, 30, 1, '2025-11-16 10:04:55', NULL),
(245, 69, 25, 1, '2025-11-16 10:04:55', NULL),
(246, 69, 16, 1, '2025-11-16 10:04:55', NULL),
(247, 69, 17, 1, '2025-11-16 10:04:55', NULL),
(248, 69, 21, 1, '2025-11-16 10:04:55', NULL),
(249, 69, 20, 1, '2025-11-16 10:04:55', NULL),
(250, 69, 15, 1, '2025-11-16 10:04:55', NULL),
(251, 69, 8, 1, '2025-11-16 10:04:55', NULL),
(252, 69, 9, 1, '2025-11-16 10:04:55', NULL),
(253, 69, 13, 1, '2025-11-16 10:04:55', NULL),
(254, 69, 12, 1, '2025-11-16 10:04:55', NULL),
(255, 69, 7, 1, '2025-11-16 10:04:55', NULL),
(258, 73, 27, 1, '2025-11-16 10:04:55', NULL),
(259, 73, 30, 1, '2025-11-16 10:04:55', NULL),
(260, 73, 25, 1, '2025-11-16 10:04:55', NULL),
(261, 73, 16, 1, '2025-11-16 10:04:55', NULL),
(262, 73, 17, 1, '2025-11-16 10:04:55', NULL),
(263, 73, 15, 1, '2025-11-16 10:04:55', NULL),
(264, 73, 8, 1, '2025-11-16 10:04:55', NULL),
(265, 73, 9, 1, '2025-11-16 10:04:55', NULL),
(266, 73, 7, 1, '2025-11-16 10:04:55', NULL),
(273, 74, 27, 1, '2025-11-16 10:04:55', NULL),
(274, 74, 30, 1, '2025-11-16 10:04:55', NULL),
(275, 74, 25, 1, '2025-11-16 10:04:55', NULL),
(276, 74, 8, 1, '2025-11-16 10:04:55', NULL),
(277, 74, 9, 1, '2025-11-16 10:04:55', NULL),
(278, 74, 13, 1, '2025-11-16 10:04:55', NULL),
(279, 74, 12, 1, '2025-11-16 10:04:55', NULL),
(280, 74, 7, 1, '2025-11-16 10:04:55', NULL),
(288, 80, 27, 1, '2025-11-16 10:04:55', NULL),
(289, 80, 25, 1, '2025-11-16 10:04:55', NULL),
(291, 81, 27, 1, '2025-11-16 10:04:55', NULL),
(292, 81, 25, 1, '2025-11-16 10:04:55', NULL),
(293, 81, 12, 1, '2025-11-16 10:04:55', NULL),
(294, 82, 27, 1, '2025-11-16 10:04:55', NULL),
(295, 82, 25, 1, '2025-11-16 10:04:55', NULL),
(296, 82, 21, 1, '2025-11-16 10:04:55', NULL),
(297, 82, 8, 1, '2025-11-16 10:04:55', NULL),
(298, 82, 9, 1, '2025-11-16 10:04:55', NULL),
(299, 82, 13, 1, '2025-11-16 10:04:55', NULL),
(300, 82, 12, 1, '2025-11-16 10:04:55', NULL),
(301, 82, 7, 1, '2025-11-16 10:04:55', NULL),
(309, 84, 27, 1, '2025-11-16 10:04:55', NULL),
(310, 84, 30, 1, '2025-11-16 10:04:55', NULL),
(311, 84, 25, 1, '2025-11-16 10:04:55', NULL),
(312, 84, 21, 1, '2025-11-16 10:04:55', NULL),
(313, 84, 8, 1, '2025-11-16 10:04:55', NULL),
(314, 84, 9, 1, '2025-11-16 10:04:55', NULL),
(315, 84, 13, 1, '2025-11-16 10:04:55', NULL),
(316, 84, 12, 1, '2025-11-16 10:04:55', NULL),
(317, 84, 7, 1, '2025-11-16 10:04:55', NULL),
(324, 85, 27, 1, '2025-11-16 10:04:55', NULL),
(325, 85, 25, 1, '2025-11-16 10:04:55', NULL),
(326, 85, 16, 1, '2025-11-16 10:04:55', NULL),
(327, 85, 17, 1, '2025-11-16 10:04:55', NULL),
(328, 85, 15, 1, '2025-11-16 10:04:55', NULL),
(329, 85, 8, 1, '2025-11-16 10:04:55', NULL),
(330, 85, 9, 1, '2025-11-16 10:04:55', NULL),
(331, 85, 13, 1, '2025-11-16 10:04:55', NULL),
(332, 85, 7, 1, '2025-11-16 10:04:55', NULL),
(339, 89, 27, 1, '2025-11-16 10:04:55', NULL),
(340, 89, 25, 1, '2025-11-16 10:04:55', NULL),
(341, 89, 16, 1, '2025-11-16 10:04:55', NULL),
(342, 89, 17, 1, '2025-11-16 10:04:55', NULL),
(343, 89, 15, 1, '2025-11-16 10:04:55', NULL),
(344, 89, 8, 1, '2025-11-16 10:04:55', NULL),
(345, 89, 9, 1, '2025-11-16 10:04:55', NULL),
(346, 89, 7, 1, '2025-11-16 10:04:55', NULL),
(354, 92, 27, 1, '2025-11-16 10:04:55', NULL),
(355, 92, 25, 1, '2025-11-16 10:04:55', NULL),
(357, 93, 13, 1, '2025-11-16 10:04:55', NULL),
(358, 94, 27, 1, '2025-11-16 10:04:55', NULL),
(359, 94, 25, 1, '2025-11-16 10:04:55', NULL),
(361, 96, 27, 1, '2025-11-16 10:04:55', NULL),
(362, 96, 30, 1, '2025-11-16 10:04:55', NULL),
(363, 96, 25, 1, '2025-11-16 10:04:55', NULL),
(364, 96, 8, 1, '2025-11-16 10:04:55', NULL),
(365, 96, 9, 1, '2025-11-16 10:04:55', NULL),
(366, 96, 13, 1, '2025-11-16 10:04:55', NULL),
(367, 96, 12, 1, '2025-11-16 10:04:55', NULL),
(368, 96, 7, 1, '2025-11-16 10:04:55', NULL),
(376, 97, 27, 1, '2025-11-16 10:04:55', NULL),
(377, 97, 25, 1, '2025-11-16 10:04:55', NULL),
(378, 97, 9, 1, '2025-11-16 10:04:55', NULL),
(379, 97, 12, 1, '2025-11-16 10:04:55', NULL),
(380, 97, 7, 1, '2025-11-16 10:04:55', NULL),
(383, 98, 8, 1, '2025-11-16 10:04:55', NULL),
(384, 98, 9, 1, '2025-11-16 10:04:55', NULL),
(385, 98, 7, 1, '2025-11-16 10:04:55', NULL),
(386, 99, 27, 1, '2025-11-16 10:04:55', NULL),
(387, 99, 25, 1, '2025-11-16 10:04:55', NULL),
(389, 105, 9, 1, '2025-11-16 10:04:55', NULL),
(390, 105, 13, 1, '2025-11-16 10:04:55', NULL),
(391, 105, 12, 1, '2025-11-16 10:04:55', NULL),
(392, 105, 7, 1, '2025-11-16 10:04:55', NULL),
(396, 106, 8, 1, '2025-11-16 10:04:55', NULL),
(397, 106, 9, 1, '2025-11-16 10:04:55', NULL),
(398, 106, 13, 1, '2025-11-16 10:04:55', NULL),
(399, 106, 12, 1, '2025-11-16 10:04:55', NULL),
(400, 106, 7, 1, '2025-11-16 10:04:55', NULL),
(403, 107, 27, 1, '2025-11-16 10:04:55', NULL),
(404, 107, 25, 1, '2025-11-16 10:04:55', NULL),
(405, 107, 12, 1, '2025-11-16 10:04:55', NULL),
(406, 108, 8, 1, '2025-11-16 10:04:55', NULL),
(407, 108, 9, 1, '2025-11-16 10:04:55', NULL),
(408, 108, 13, 1, '2025-11-16 10:04:55', NULL),
(409, 108, 7, 1, '2025-11-16 10:04:55', NULL),
(413, 109, 12, 1, '2025-11-16 10:04:55', NULL),
(414, 110, 13, 1, '2025-11-16 10:04:55', NULL),
(415, 111, 13, 1, '2025-11-16 10:04:55', NULL),
(416, 112, 13, 1, '2025-11-16 10:04:55', NULL),
(417, 113, 13, 1, '2025-11-16 10:04:55', NULL),
(418, 114, 13, 1, '2025-11-16 10:04:55', NULL),
(419, 115, 13, 1, '2025-11-16 10:04:55', NULL),
(420, 119, 12, 1, '2025-11-16 10:04:55', NULL),
(421, 120, 27, 1, '2025-11-16 10:04:55', NULL),
(422, 120, 25, 1, '2025-11-16 10:04:55', NULL),
(423, 120, 17, 1, '2025-11-16 10:04:55', NULL),
(424, 120, 15, 1, '2025-11-16 10:04:55', NULL),
(425, 120, 8, 1, '2025-11-16 10:04:55', NULL),
(426, 120, 9, 1, '2025-11-16 10:04:55', NULL),
(427, 120, 13, 1, '2025-11-16 10:04:55', NULL),
(428, 120, 12, 1, '2025-11-16 10:04:55', NULL),
(429, 120, 7, 1, '2025-11-16 10:04:55', NULL),
(437, 122, 27, 1, '2025-11-16 10:04:55', NULL),
(438, 122, 25, 1, '2025-11-16 10:04:55', NULL),
(440, 124, 27, 1, '2025-11-16 10:04:55', NULL),
(441, 124, 25, 1, '2025-11-16 10:04:55', NULL),
(443, 125, 27, 1, '2025-11-16 10:04:55', NULL),
(444, 125, 30, 1, '2025-11-16 10:04:55', NULL),
(445, 125, 25, 1, '2025-11-16 10:04:55', NULL),
(446, 125, 13, 1, '2025-11-16 10:04:55', NULL),
(447, 125, 12, 1, '2025-11-16 10:04:55', NULL),
(450, 128, 27, 1, '2025-11-16 10:04:55', NULL),
(451, 128, 25, 1, '2025-11-16 10:04:55', NULL),
(453, 130, 12, 1, '2025-11-16 10:04:55', NULL),
(454, 131, 27, 1, '2025-11-16 10:04:55', NULL),
(455, 131, 25, 1, '2025-11-16 10:04:55', NULL),
(457, 132, 27, 1, '2025-11-16 10:04:55', NULL),
(458, 132, 25, 1, '2025-11-16 10:04:55', NULL),
(460, 134, 27, 1, '2025-11-16 10:04:55', NULL),
(461, 134, 25, 1, '2025-11-16 10:04:55', NULL);

-- --------------------------------------------------------

--
-- 資料表結構 `user_roles`
--

CREATE TABLE `user_roles` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL COMMENT '使用者ID',
  `role_id` int UNSIGNED NOT NULL COMMENT '角色ID',
  `granted_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '授權時間',
  `granted_by` bigint UNSIGNED DEFAULT NULL COMMENT '授權者ID'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='使用者-角色關聯表';

--
-- 傾印資料表的資料 `user_roles`
--

INSERT INTO `user_roles` (`id`, `user_id`, `role_id`, `granted_at`, `granted_by`) VALUES
(1, 12, 1, '2025-11-16 10:04:55', NULL);

-- --------------------------------------------------------

--
-- 替換檢視表以便查看 `v_role_permission_stats`
-- (請參考以下實際畫面)
--
CREATE TABLE `v_role_permission_stats` (
`permission_count` bigint
,`role_display_name` varchar(255)
,`role_id` int unsigned
,`role_name` varchar(100)
,`user_count` bigint
);

-- --------------------------------------------------------

--
-- 替換檢視表以便查看 `v_user_all_permissions`
-- (請參考以下實際畫面)
--
CREATE TABLE `v_user_all_permissions` (
`action` varchar(50)
,`category` varchar(50)
,`is_granted` int
,`login_id` varchar(255)
,`module` varchar(50)
,`permission_display_name` varchar(255)
,`permission_id` int unsigned
,`permission_name` varchar(100)
,`source` varchar(6)
,`user_id` bigint unsigned
,`user_name` varchar(255)
);

--
-- 已傾印資料表的索引
--

--
-- 資料表索引 `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- 資料表索引 `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_name` (`name`),
  ADD KEY `idx_name` (`name`),
  ADD KEY `idx_module` (`module`),
  ADD KEY `idx_category` (`category`),
  ADD KEY `idx_module_category` (`module`,`category`);

--
-- 資料表索引 `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_name` (`name`),
  ADD KEY `idx_name` (`name`);

--
-- 資料表索引 `role_permissions`
--
ALTER TABLE `role_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_role_permission` (`role_id`,`permission_id`),
  ADD KEY `idx_role_id` (`role_id`),
  ADD KEY `idx_permission_id` (`permission_id`);

--
-- 資料表索引 `sys_loginsystem`
--
ALTER TABLE `sys_loginsystem`
  ADD PRIMARY KEY (`sysloginID`);

--
-- 資料表索引 `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_login_id` (`login_id`),
  ADD KEY `idx_login_id` (`login_id`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_email` (`email`);

--
-- 資料表索引 `user_notes`
--
ALTER TABLE `user_notes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_user_note_type` (`user_id`,`note_type`),
  ADD KEY `idx_user_id` (`user_id`);

--
-- 資料表索引 `user_permissions`
--
ALTER TABLE `user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_user_permission` (`user_id`,`permission_id`),
  ADD KEY `idx_user_id` (`user_id`),
  ADD KEY `idx_permission_id` (`permission_id`);

--
-- 資料表索引 `user_roles`
--
ALTER TABLE `user_roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_user_role` (`user_id`,`role_id`),
  ADD KEY `idx_user_id` (`user_id`),
  ADD KEY `idx_role_id` (`role_id`);

--
-- 在傾印的資料表使用自動遞增(AUTO_INCREMENT)
--

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=57;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `role_permissions`
--
ALTER TABLE `role_permissions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=57;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `sys_loginsystem`
--
ALTER TABLE `sys_loginsystem`
  MODIFY `sysloginID` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=135;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=135;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `user_notes`
--
ALTER TABLE `user_notes`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `user_permissions`
--
ALTER TABLE `user_permissions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=591;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `user_roles`
--
ALTER TABLE `user_roles`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

-- --------------------------------------------------------

--
-- 檢視表結構 `v_role_permission_stats`
--
DROP TABLE IF EXISTS `v_role_permission_stats`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_role_permission_stats`  AS SELECT `r`.`id` AS `role_id`, `r`.`name` AS `role_name`, `r`.`display_name` AS `role_display_name`, count(distinct `rp`.`permission_id`) AS `permission_count`, count(distinct `ur`.`user_id`) AS `user_count` FROM ((`roles` `r` left join `role_permissions` `rp` on((`r`.`id` = `rp`.`role_id`))) left join `user_roles` `ur` on((`r`.`id` = `ur`.`role_id`))) GROUP BY `r`.`id` ;

-- --------------------------------------------------------

--
-- 檢視表結構 `v_user_all_permissions`
--
DROP TABLE IF EXISTS `v_user_all_permissions`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_user_all_permissions`  AS SELECT DISTINCT `u`.`id` AS `user_id`, `u`.`login_id` AS `login_id`, `u`.`name` AS `user_name`, `p`.`id` AS `permission_id`, `p`.`name` AS `permission_name`, `p`.`display_name` AS `permission_display_name`, `p`.`module` AS `module`, `p`.`category` AS `category`, `p`.`action` AS `action`, (case when (`up`.`id` is not null) then 'direct' else 'role' end) AS `source`, (case when (`up`.`id` is not null) then `up`.`is_granted` else 1 end) AS `is_granted` FROM ((((`users` `u` left join `user_roles` `ur` on((`u`.`id` = `ur`.`user_id`))) left join `role_permissions` `rp` on((`ur`.`role_id` = `rp`.`role_id`))) left join `permissions` `p` on((`rp`.`permission_id` = `p`.`id`))) left join `user_permissions` `up` on(((`u`.`id` = `up`.`user_id`) and (`p`.`id` = `up`.`permission_id`)))) WHERE (`u`.`status` = 'active') ;

--
-- 已傾印資料表的限制式
--

--
-- 資料表的限制式 `role_permissions`
--
ALTER TABLE `role_permissions`
  ADD CONSTRAINT `fk_role_permissions_permission` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_role_permissions_role` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- 資料表的限制式 `user_notes`
--
ALTER TABLE `user_notes`
  ADD CONSTRAINT `fk_user_notes_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- 資料表的限制式 `user_permissions`
--
ALTER TABLE `user_permissions`
  ADD CONSTRAINT `fk_user_permissions_permission` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_user_permissions_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- 資料表的限制式 `user_roles`
--
ALTER TABLE `user_roles`
  ADD CONSTRAINT `fk_user_roles_role` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_user_roles_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
