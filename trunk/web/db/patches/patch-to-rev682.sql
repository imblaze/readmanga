-- from revision 617
 CREATE TABLE `manga_edit_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `completed` bit(1) NOT NULL,
  `description` longtext ,
  `eng_name` varchar(255)  NOT NULL,
  `jp_name` varchar(255)  DEFAULT NULL,
  `manga_id` bigint(20) NOT NULL,
  `mature` bit(1) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `single` bit(1) NOT NULL,
  `translation_completed` bit(1) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `volume_count` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `eng_name` (`eng_name`),
  KEY `FKEE692F84C14815F` (`manga_id`),
  KEY `FKEE692F88D85DD10` (`user_id`)
) ENGINE=MyISAM;


CREATE TABLE `shiro_role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `name` varchar(255)  NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM;

CREATE TABLE `shiro_role_permissions` (
  `shiro_role_id` bigint(20) DEFAULT NULL,
  `permissions_string` varchar(255)  DEFAULT NULL,
  KEY `FK389B46C9DE1FACE2` (`shiro_role_id`)
) ENGINE=MyISAM;

CREATE TABLE `shiro_user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `forum_id` int(11) NOT NULL,
  `trans_id` bigint(20) DEFAULT NULL,
  `username` varchar(255)  NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `forum_id` (`forum_id`),
  KEY `FKE588455933CE8B27` (`trans_id`)
) ENGINE=MyISAM;

CREATE TABLE `shiro_user_permissions` (
  `shiro_user_id` bigint(20) DEFAULT NULL,
  `permissions_string` varchar(255)  DEFAULT NULL,
  KEY `FK34555A9E834A70C2` (`shiro_user_id`)
) ENGINE=MyISAM;

CREATE TABLE `shiro_user_roles` (
  `shiro_role_id` bigint(20) NOT NULL,
  `shiro_user_id` bigint(20) NOT NULL,
  PRIMARY KEY (`shiro_user_id`,`shiro_role_id`),
  KEY `FKBA221057834A70C2` (`shiro_user_id`),
  KEY `FKBA221057DE1FACE2` (`shiro_role_id`)
) ENGINE=MyISAM;


ALTER TABLE `submission` 
  ADD COLUMN `hidden` bit(1) NOT NULL AFTER date_created;


DROP TABLE user_settings;

CREATE TABLE `twitt` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `date_created` datetime NOT NULL,
  `manga_id` bigint(20) NOT NULL,
  `message` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `page` int(11) NOT NULL,
  `sub_id` bigint(20) DEFAULT NULL,
  `user_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK69A57464C14815F` (`manga_id`),
  KEY `FK69A57468D85DD10` (`user_id`),
  KEY `FK69A57469D2AF9C1` (`sub_id`)
) ENGINE=MyISAM;

INSERT INTO shiro_role(id, name) VALUES(1, 'USER');
INSERT INTO shiro_role(id, name) VALUES(2, 'ADMIN');
INSERT INTO shiro_role(id, name) VALUES(3, 'MODERATOR');

