CREATE TABLE IF NOT EXISTS `coa_old_school_equipment_corpse` (
  `id` bigint unsigned NOT NULL,
  `owner` int unsigned NOT NULL,
  `map` smallint unsigned NOT NULL,
  `instance` int unsigned NOT NULL,
  `x` float NOT NULL,
  `y` float NOT NULL,
  `z` float NOT NULL,
  `o` float NOT NULL,
  `display` int unsigned NOT NULL,
  `created` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `owner_location` (`owner`, `map`, `instance`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `coa_old_school_equipment_corpse_item` (
  `corpse` bigint unsigned NOT NULL,
  `item_guid` int unsigned NOT NULL,
  `slot` tinyint unsigned NOT NULL,
  PRIMARY KEY (`corpse`, `item_guid`),
  UNIQUE KEY `item_guid` (`item_guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
