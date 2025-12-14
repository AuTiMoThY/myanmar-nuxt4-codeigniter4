-- phpMyAdmin SQL Dump
-- 
-- 資料表格式： `sysstructure`
-- 系統架構層級表（樹狀結構）
-- 

CREATE TABLE `sysstructure` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主鍵 ID',
  `parent_id` int(11) unsigned DEFAULT NULL COMMENT '父層級 ID（NULL 表示第一層級）',
  `label` varchar(100) NOT NULL COMMENT '層級名稱',
  `module_id` int(11) unsigned DEFAULT NULL COMMENT '模組 ID（關聯到 sysmodule 表）',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否上線（0=否，1=是）',
  `sort_order` int(11) NOT NULL DEFAULT '0' COMMENT '排序順序',
  `is_show_frontend` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否顯示前台（0=否，1=是）',
  `is_show_backend` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否顯示後台（0=否，1=是）',
  `created_at` datetime DEFAULT NULL COMMENT '建立時間',
  `updated_at` datetime DEFAULT NULL COMMENT '更新時間',
  PRIMARY KEY (`id`),
  KEY `idx_parent_id` (`parent_id`),
  KEY `idx_module_id` (`module_id`),
  KEY `idx_status` (`status`),
  KEY `idx_sort_order` (`sort_order`),
  CONSTRAINT `fk_sysstructure_parent` FOREIGN KEY (`parent_id`) REFERENCES `sysstructure` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='系統架構層級表';
