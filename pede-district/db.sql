CREATE TABLE `settings_district_pede` (
  `pedeid` varchar(255) NOT NULL,
  `enabled` int(11) DEFAULT 0,
  `ox_notify` int(11) DEFAULT 1,
  `last_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;