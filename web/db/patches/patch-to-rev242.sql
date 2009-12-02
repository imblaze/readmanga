-- from revision 196
CREATE TABLE `alert` (
  `id` bigint(20) NOT NULL auto_increment,
  `version` bigint(20) NOT NULL,
  `date_created` datetime NOT NULL,
  `message` varchar(255) NOT NULL,
  PRIMARY KEY  (`id`)
);

CREATE TABLE `genre` (
  `id` bigint(20) NOT NULL auto_increment,
  `version` bigint(20) NOT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY  (`id`)
); 

CREATE TABLE `manga_genre` (
  `manga_genres_id` bigint(20) default NULL,
  `genre_id` bigint(20) default NULL,
  `genres_idx` int(11) default NULL,
  KEY `FK29689938B0B07AFF` (`genre_id`)
);
