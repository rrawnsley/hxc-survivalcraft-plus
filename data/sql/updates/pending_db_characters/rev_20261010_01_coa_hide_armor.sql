-- .hidearmor preference, stored per character.
CREATE TABLE IF NOT EXISTS `coa_hide_armor` (
  `guid` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
