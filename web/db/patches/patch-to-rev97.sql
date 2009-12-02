-- from revision 82
ALTER TABLE feedback
  ADD COLUMN `type` int(11) NOT NULL;

CREATE TABLE `visit`(
  `id` bigint(20) NOT NULL auto_increment,
  `chapter_id` bigint(20) default NULL,
  `date_created` datetime NOT NULL,
  `ip` varchar(255) NOT NULL,
  `manga_id` bigint(20) NOT NULL,
  `session_id` varchar(255) default NULL,
  PRIMARY KEY  (`id`),
  KEY `FK6B04D4B4C14815F` (`manga_id`),
  KEY `FK6B04D4BCCA8997F` (`chapter_id`)
);
