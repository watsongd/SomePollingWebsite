# README

Ruby version -- 2.3.1

Rails 5.0

### Database setup

Using sqlite for database.

Initialize the database with the following command:
```
rake db:migrate
```
Run the seed file:
```
rake db:seed
```
Or do it all at once:
```
rake db:setup
```

### Using the server

Using puma for server

To start the server locally, run:
```
rails server
```
Or specify a port with the -p tag:
```
rails server -p 3002
```
