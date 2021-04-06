INSERT INTO `addon_account` (`name`, `label`, `shared`) VALUES
	('society_madrazo', 'Madrazo', 1);

INSERT INTO `addon_inventory` (`name`, `label`, `shared`) VALUES
	('society_madrazo', 'Madrazo', 1);

INSERT INTO `datastore` (`name`, `label`, `shared`) VALUES
	('society_madrazo', 'Madrazo', 1),
	('society_weapons_madrazo', 'Weapons Madrazo', 1);

INSERT INTO `factions` (`name`, `label`) VALUES
	('madrazo','Madrazo');

INSERT INTO `faction_grades` (`faction_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
	('madrazo', 0, 'recrue', 'Homme De Main', 0, '{}', '{}'),
	('madrazo', 1, 'affranchis', 'Bras Droits', 0, '{}', '{}'),
	('madrazo', 2, 'boss', 'Chef Du Cartel', 0, '{}', '{}');