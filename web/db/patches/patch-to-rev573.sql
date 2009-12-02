-- from revision 362
ALTER TABLE manga ADD COLUMN `topic_id` int(11) NOT NULL AFTER single;
CREATE TABLE `user_settings` (
   `id` bigint(20) NOT NULL auto_increment,
   `version` bigint(20) NOT NULL,
   `admin` bit(1) NOT NULL,
   `trans_id` bigint(20) default NULL,
   `user_id` int(11) NOT NULL,
   PRIMARY KEY  (`id`),
   UNIQUE KEY `user_id` (`user_id`),
   KEY `FK5886161733CE8B27` (`trans_id`)
);
