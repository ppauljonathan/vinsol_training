create database if not exists vtapp;
CREATE USER 'vtapp_user'@'vtapp';
SET PASSWORD FOR vtapp_user@vtapp = PASSWORD('hey i am a vtapp user');
GRANT ALL PRIVILEGES ON vtapp.* TO 'vtapp_user'@'vtapp';
drop user vtapp_user@vtapp;
drop DATABASE vtapp;