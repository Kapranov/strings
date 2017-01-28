> DataMapper is an ORM:

DataMapper is an ORM: an Object-Relational Mapping. Basically, it’s a
library that lets you work with your database from object-oriented code.
There’s absolutely no SQL in this tutorial at all. However, an ORM uses
a regular database under the covers; we’ll be using sqlite3 today, but
you could just use a different adapter to work with a mysql, postgresql
or other database.

```
bash> ruby -Ilib application.rb
```

```
curl http://localhost:4567/users

curl -d "user[first_name]=Oleg&\
  user[last_name]=Kapranov&user[middle_name]='G.'&\
  user[email]='lugatex@yahoo.com'&\
  user[token]='0cMkt16MRHdqokyV8HvsSzvkpoSJMzyWXQtt'&\
  user[description]='Hello World!'" http://localhost:4567/users

curl -d "user[first_name]=John&\
  user[last_name]=Adams&user[middle_name]='W.'&\
  user[email]='adams@yahoo.com'&\
  user[token]='0tthgjkFHfdkll248HvsSzvkpdsfMzyfsfdt'&\
  user[description]='Hello John!'" http://localhost:4567/users

curl -d "user[first_name]=Sean&\
  user[last_name]=Bristol&user[middle_name]='H.'&\
  user[email]='bristol@yahoo.com'&\
  user[token]='sfFDGfgdgopi5657wsfg13456oSJMzyWXQtt'&\
  user[description]='Hello Sean!'" http://localhost:4567/users

curl -d "user[first_name]=Brian&\
  user[last_name]=Williams&user[middle_name]='G.'&\
  user[email]='williams@yahoo.com'&\
  user[token]='355ASwfdgopi5657dgf8734gjjSJMzyWXQtt'&\
  user[description]='Hello Brian!'" http://localhost:4567/users

curl -X PUT -d "user[description]='GoodBye\!'" http://localhost:4567/users/2

curl -X DELETE http://localhost:4567/users/3



```
