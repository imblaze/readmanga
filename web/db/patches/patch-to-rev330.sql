-- from revision 307
 CREATE TABLE `site_block` (
  `id` bigint(20) NOT NULL auto_increment,
  `version` bigint(20) NOT NULL,
  `body` longtext NOT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY  (`id`)
);

INSERT INTO site_block VALUES(null, 1, '<p>
Мы создали этот сайт специально для таких же любителей манги как и мы. 
Здесь можно читать мангу онлайн, при этом можно выбрать наиболее 
приятный цвет фона, и листать страницы при помощи кнопок курсора на 
клавиатуре. Впрочем, это можно делать и нажимая на страницу мышкой.
</p>
<p>
Наш сайт еще в процессе разработки, поэтому каких-то важных вещей 
надо подождать. Однако они скоро будут. Например, жанры и авторы  
появятся в течение 2-3 дней.
</p>
<p>Если у вас есть манга, переведенная на русский, <a 
href="/feedback/index?type=SUBMISSION">сообщите нам</a>.
Мы будем рады ее разместить.</p>
<p>Также мы будем очень благодарны, если вы <a 
href="/feedback/index?type=OPINION">поделитесь своими идеями и
пожеланиями</a> по поводу сайта. Мы очень стараемся сделать его 
хорошим!</p>
<p>Пожалуйста, обратите внимание! Авторами переводов являемся не мы. 
Адреса проектов по переводу указаны в описании манги.</p>

<p style="text-align: right"><i>Команда ReadManga.ru</i></p>', 'welcome');
INSERT INTO site_block VALUES(null, 1, '', 'user_agreement');
INSERT INTO site_block VALUES(null, 1, '<p><i>10.06.2009</i> В описание манги добавлены ссылки на сайты 
переводчиков и информация об объеме манги, ее завершенности и 
завершенности перевода.</p>', 'news');
INSERT INTO site_block VALUES(null, 1, '', 'copyright_holders');
INSERT INTO site_block VALUES(null, 1, '', 'upload');


CREATE TABLE `book` (
  `id` bigint(20) NOT NULL auto_increment,
  `version` bigint(20) NOT NULL,
  `link` varchar(255) NOT NULL,
  `manga_id` bigint(20) NOT NULL,
  `name` varchar(255) NOT NULL,
  `books_idx` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `FK2E3AE94C14815F` (`manga_id`)
);
