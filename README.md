Instrucciones
-----------------
- Levantar rack

	$ rackup

- Subir a Heroku

	$ git push origin master

	Ir a la consola web de heroku y desplegar manualmente.

- Ejecutar Migraciones

	$ heroku run rake db:migrate --app test-automation-shop

- Limpiar la data
	$ heroku run rake db:migrate VERSION=0 --app test-automation-shop
	$ heroku run rake db:migrate --app test-automation-shop
	$ heroku run rake db:seed --app test-automation-shop

	curl http://test-automation-shop.herokuapp.com/clear

- Ver los logs

	$ heroku logs --app test-automation-shop