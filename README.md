Instrucciones
-----------------
- Levantar rack

	$ rackup

- Subir a Heroku

	$ git push origin master

	Ir a la consola web de heroku y desplegar manualmente.

- Ejecutar Migraciones

	$ heroku run rake db:migrate --app test-automation-shop

- Ver los logs

	$ heroku logs --app test-automation-shop