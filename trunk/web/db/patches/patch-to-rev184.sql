-- from revision 174
ALTER TABLE submission DISABLE KEYS;

ALTER TABLE submission
  ADD COLUMN location int(11) NOT NULL;

UPDATE submission set location=1;

ALTER TABLE submission ENABLE KEYS;

UPDATE page set url = replace(url, 'http://i.readmanga.ru/', '')
