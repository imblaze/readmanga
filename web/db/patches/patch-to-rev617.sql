-- from revision 573
ALTER TABLE manga ADD `picture` varchar(255) AFTER name;
ALTER TABLE user_settings ADD `moderator` bit(1) NOT NULL AFTER admin;
