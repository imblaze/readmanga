ALTER TABLE chapter
   ADD COLUMN `sub_id` bigint(20) default NULL AFTER num,
   ADD KEY `FK2C0C7C4D9D2AF9C1` (`sub_id`);

CREATE TABLE `feedback` (                 
  `id` bigint(20) NOT NULL auto_increment,
  `version` bigint(20) NOT NULL,
  `date_created` datetime NOT NULL,
  `name` varchar(255) NOT NULL,
  `text` varchar(255) NOT NULL,
  PRIMARY KEY  (`id`)
);

UPDATE chapter c 
  INNER JOIN submission s 
  ON c.id = s.chapter_id 
  SET c.sub_id = s.id;
