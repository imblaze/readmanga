-- from revision 700
ALTER TABLE twitt 
 DROP COLUMN  manga_id,
 MODIFY sub_id bigint(20) NOT NULL;

ALTER TABLE submission 
 DROP KEY FK84363B4CCCA8997F,
 DROP COLUMN chapter_id;

