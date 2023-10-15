CREATE TABLE `settings_district_pede` (
  `pedeid` varchar(255) NOT NULL,
  `enabled` INT DEFAULT '0',
  `last_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

ALTER TABLE `settings_district_pede`
  ADD UNIQUE KEY `pedeid` (`pedeid`);
COMMIT;