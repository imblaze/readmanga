-- from revision 242
CREATE TABLE `translator` (
  `id` bigint(20) NOT NULL auto_increment,
  `version` bigint(20) NOT NULL,
  `link` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY  (`id`)
);

CREATE TABLE `manga_translator` (
  `manga_translators_id` bigint(20) default NULL,
  `translator_id` bigint(20) default NULL,
  `translators_idx` int(11) default NULL,
  KEY `FKDFCE3385F63B675` (`translator_id`)
);
