-- phpMyAdmin SQL Dump
-- 
-- 資料表格式： `sysmodule`
-- 系統模組表
-- 

CREATE TABLE `sysmodule` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主鍵 ID',
  `label` varchar(100) NOT NULL COMMENT '模組名稱',
  `name` varchar(100) NOT NULL COMMENT '模組代碼（唯一，只能包含字母、數字、底線和連字號）',
  `created_at` datetime DEFAULT NULL COMMENT '建立時間',
  `updated_at` datetime DEFAULT NULL COMMENT '更新時間',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_name` (`name`),
  KEY `idx_label` (`label`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='系統模組表';
