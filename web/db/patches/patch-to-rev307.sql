-- from revision 294
ALTER TABLE manga 
  ADD COLUMN `mature` bit(1) NOT NULL after link_name;
