-- from revision 184
ALTER TABLE page 
  ADD COLUMN `submission_id` bigint(20) NOT NULL AFTER size,
  ADD COLUMN `pages_idx` int(11) default NULL,
  ADD KEY `FK34628F754ED135` (`submission_id`);

UPDATE page p 
  INNER JOIN submission_page sp
  ON p.id = sp.page_id
  SET p.submission_id = sp.submission_pages_id,
      p.pages_idx = sp.pages_idx;

DROP TABLE submission_page;
