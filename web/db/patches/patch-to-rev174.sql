-- from revision 139
ALTER TABLE manga 
  ADD COLUMN `jp_name` varchar(255) default NULL AFTER eng_name;
