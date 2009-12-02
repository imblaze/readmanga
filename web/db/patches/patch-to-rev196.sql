-- from revision 185
ALTER TABLE manga DISABLE KEYS;

ALTER TABLE manga 
  ADD COLUMN `completed` bit(1) NOT NULL AFTER version,
  ADD COLUMN `single` bit(1) NOT NULL,
  ADD COLUMN `translation_completed` bit(1) NOT NULL,
  ADD COLUMN `volume_count` int(11) NOT NULL;

UPDATE manga set completed = 0, single = 0, translation_completed = 0, volume_count=1;

ALTER TABLE manga ENABLE KEYS;
