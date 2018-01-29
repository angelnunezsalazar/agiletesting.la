## AGILE TESTING LATAM ##

Instrucciones
-----------------
- Levantar localmente el web server

	$ rackup

- Desplegar a Heroku

	$ git push origin master

	Heroku extraerá automáticamente los cambios y los desplegará en su plataforma

Configuring Domain
--------------------

	$ heroku config:add CANONICAL_HOST=www.agiletesting.la --app agiletesting
	$ heroku domains:add agiletesting.la --app agiletesting
	$ heroku domains:add www.agiletesting.la --app agiletesting

Notas: https://github.com/Helabs/pah/wiki/Configuring-domain-on-Heroku

Actualizar BD
----------------

- Ejecutar Migraciones

	$ heroku run rake db:migrate --app agiletesting

- Reinicializar toda la BD

	$ db/drop_all_tables.sh
	$ heroku run rake db:migrate --app agiletesting

Logs
-----------------
- Logs de la aplicación

	$ heroku logs --app agiletesting

- Logs de la BD

	$ heroku logs --tail --ps postgres --app agiletesting

Postgresql
------------------
Conectarse

	$ heroku pg:psql --app agiletesting

Consultar todas las tablas

	$ SELECT table_name FROM information_schema.tables WHERE table_schema='public';

Consultar todas las columnas de una tabla

	$ select column_name from information_schema.columns where table_name = 'TABLA';