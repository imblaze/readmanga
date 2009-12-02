-- from revision 682
ALTER TABLE manga_edit_info DROP KEY `eng_name`;
ALTER TABLE `submission`
 ADD COLUMN   `user_id` bigint(20) DEFAULT NULL AFTER location,
 ADD KEY `FK84363B4C8D85DD10` (`user_id`);

