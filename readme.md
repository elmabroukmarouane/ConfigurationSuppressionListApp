# ConfigurationSuppressionListApp

Developed by Laravel 5.6 & Vue JS 2

A [Laravel](http://laravel.com/), [Vue JS](https://vuejs.org/) and [Vuetify](https://vuetifyjs.com/) application for automatic configuration of servers.

- The servers information (IP address, Username[root], password) are saved in the database and then the server is configured automatically using shells and linux command into PHP. Also, It allows you to upload necessary files and save necessary information in the database. A Users management is made for management the users of the application.
- All the code is written by me.

## Installation

- composer install
- npm install
- Create database of the authentification and fill the database name and username and password database in the .env file
- Create the database of servers information and import it into MySQL (Command : "mysql -u <username> -p <password> -h <host> <database_name> < <path_to_database_sql_file>" It is included in the ./DB directory)
- php artisan migrate --seed or php artisan migrate:refresh **(if you have already the database with it tables). You will find a sample data generated automatically by the seed files**
- php artisan serve
- Use the [http://localhost:8000](http://localhost:8000) in the browser to view the application

## Live Demo

Here is the link for Live demo [Live Demo](http://elmabroukmarouane.pw/ConfigSupApp)

- Account :
  Super Administrator :
  Email : [super_admin@mail.com](super_admin@mail.com)
  Password : 123456

## Contact :

EL MABROUK Marouane : [elmabroukmarouane@gmail.com](elmabroukmarouane@gmail.com)
