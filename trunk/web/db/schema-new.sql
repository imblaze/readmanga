SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `alert` (
  `id` bigint(20) NOT NULL auto_increment,
  `version` bigint(20) NOT NULL,
  `date_created` datetime NOT NULL,
  `message` varchar(255) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `book` (
  `id` bigint(20) NOT NULL auto_increment,
  `version` bigint(20) NOT NULL,
  `link` varchar(255) NOT NULL,
  `manga_id` bigint(20) NOT NULL,
  `name` varchar(255) NOT NULL,
  `books_idx` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `FK2E3AE94C14815F` (`manga_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `browser_info` (
  `id` bigint(20) NOT NULL auto_increment,
  `version` bigint(20) NOT NULL,
  `info` varchar(255) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `chapter` (
  `id` bigint(20) NOT NULL auto_increment,
  `version` bigint(20) NOT NULL,
  `extra` bit(1) NOT NULL,
  `manga_id` bigint(20) NOT NULL,
  `name` varchar(255) default NULL,
  `num` int(11) NOT NULL,
  `sub_id` bigint(20) default NULL,
  `vol` int(11) NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `vol` (`vol`,`manga_id`,`num`),
  KEY `FK2C0C7C4D4C14815F` (`manga_id`),
  KEY `FK2C0C7C4D9D2AF9C1` (`sub_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `feedback` (
  `id` bigint(20) NOT NULL auto_increment,
  `version` bigint(20) NOT NULL,
  `date_created` datetime NOT NULL,
  `name` varchar(255) NOT NULL,
  `text` longtext NOT NULL,
  `type` int(11) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `genre` (
  `id` bigint(20) NOT NULL auto_increment,
  `version` bigint(20) NOT NULL,
  `name` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `manga` (
  `id` bigint(20) NOT NULL auto_increment,
  `version` bigint(20) NOT NULL,
  `completed` bit(1) NOT NULL,
  `description` longtext,
  `eng_name` varchar(255) NOT NULL,
  `jp_name` varchar(255) default NULL,
  `link_name` varchar(255) NOT NULL,
  `mature` bit(1) NOT NULL,
  `name` varchar(255) default NULL,
  `picture` varchar(255) default NULL,
  `rating` int(11) NOT NULL,
  `single` bit(1) NOT NULL,
  `topic_id` int(11) NOT NULL,
  `translation_completed` bit(1) NOT NULL,
  `volume_count` int(11) NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `eng_name` (`eng_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `manga_edit_info` (
  `id` bigint(20) NOT NULL auto_increment,
  `version` bigint(20) NOT NULL,
  `completed` bit(1) NOT NULL,
  `description` longtext,
  `eng_name` varchar(255) NOT NULL,
  `jp_name` varchar(255) default NULL,
  `manga_id` bigint(20) NOT NULL,
  `mature` bit(1) NOT NULL,
  `name` varchar(255) default NULL,
  `single` bit(1) NOT NULL,
  `translation_completed` bit(1) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `volume_count` int(11) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `FKEE692F84C14815F` (`manga_id`),
  KEY `FKEE692F88D85DD10` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `manga_genre` (
  `manga_genres_id` bigint(20) default NULL,
  `genre_id` bigint(20) default NULL,
  `genres_idx` int(11) default NULL,
  KEY `FK29689938B0B07AFF` (`genre_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `manga_translator` (
  `manga_translators_id` bigint(20) default NULL,
  `translator_id` bigint(20) default NULL,
  `translators_idx` int(11) default NULL,
  KEY `FKDFCE3385F63B675` (`translator_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `page` (
  `id` bigint(20) NOT NULL auto_increment,
  `version` bigint(20) NOT NULL,
  `h` int(11) NOT NULL,
  `md5` varchar(255) NOT NULL,
  `size` int(11) NOT NULL,
  `submission_id` bigint(20) NOT NULL,
  `type` varchar(255) NOT NULL,
  `url` varchar(255) NOT NULL,
  `w` int(11) NOT NULL,
  `pages_idx` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `FK34628F754ED135` (`submission_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `shiro_role` (
  `id` bigint(20) NOT NULL auto_increment,
  `version` bigint(20) NOT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `shiro_role_permissions` (
  `shiro_role_id` bigint(20) default NULL,
  `permissions_string` varchar(255) default NULL,
  KEY `FK389B46C9DE1FACE2` (`shiro_role_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `shiro_user` (
  `id` bigint(20) NOT NULL auto_increment,
  `version` bigint(20) NOT NULL,
  `forum_id` int(11) NOT NULL,
  `trans_id` bigint(20) default NULL,
  `username` varchar(255) NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `forum_id` (`forum_id`),
  KEY `FKE588455933CE8B27` (`trans_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `shiro_user_permissions` (
  `shiro_user_id` bigint(20) default NULL,
  `permissions_string` varchar(255) default NULL,
  KEY `FK34555A9E834A70C2` (`shiro_user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `shiro_user_roles` (
  `shiro_role_id` bigint(20) NOT NULL,
  `shiro_user_id` bigint(20) NOT NULL,
  PRIMARY KEY  (`shiro_user_id`,`shiro_role_id`),
  KEY `FKBA221057834A70C2` (`shiro_user_id`),
  KEY `FKBA221057DE1FACE2` (`shiro_role_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `site_block` (
  `id` bigint(20) NOT NULL auto_increment,
  `version` bigint(20) NOT NULL,
  `body` longtext NOT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `submission` (
  `id` bigint(20) NOT NULL auto_increment,
  `version` bigint(20) NOT NULL,
  `date_created` datetime NOT NULL,
  `hidden` bit(1) NOT NULL,
  `last_updated` datetime NOT NULL,
  `location` int(11) NOT NULL,
  `user_id` bigint(20) default NULL,
  PRIMARY KEY  (`id`),
  KEY `FK84363B4C8D85DD10` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `translator` (
  `id` bigint(20) NOT NULL auto_increment,
  `version` bigint(20) NOT NULL,
  `link` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `twitt` (
  `id` bigint(20) NOT NULL auto_increment,
  `version` bigint(20) NOT NULL,
  `date_created` datetime NOT NULL,
  `message` varchar(250) NOT NULL,
  `page` int(11) NOT NULL,
  `sub_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `FK69A57468D85DD10` (`user_id`),
  KEY `FK69A57469D2AF9C1` (`sub_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `visit` (
  `id` bigint(20) NOT NULL auto_increment,
  `browser_info_id` bigint(20) NOT NULL,
  `chapter_id` bigint(20) default NULL,
  `date_created` datetime NOT NULL,
  `ip` varchar(255) NOT NULL,
  `manga_id` bigint(20) NOT NULL,
  `session_id` varchar(255) default NULL,
  PRIMARY KEY  (`id`),
  KEY `FK6B04D4B4C14815F` (`manga_id`),
  KEY `FK6B04D4BCCA8997F` (`chapter_id`),
  KEY `FK6B04D4B8A9FAC90` (`browser_info_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;
