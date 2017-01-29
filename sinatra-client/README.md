### Application

This is not about making web pages, which is another valid way to use sinatra,
it's just about getting the APIs together and using JSON. Of course this can be
adapted to use XML easily enough, and I'll show how to do that.

I'm assuming that your job is to make mobile applications, and that you would
love to have a live server living locally to test your processing and interactions.
This can help. And if you can get data examples from your client, then that's even
better, as you can encode them in your local server and do some more relevant testing.

Some knowledge of Ruby is required, but you are all programmers, so I'm assuming that
you have it, or that you can pick enough up at the drop of a hat. I'll give you some
links to fast references which can help. Ask questions if you spot anything odd in
the code.

The server framework we will use is called Sinatra. It's a Ruby web framework which
you can use instead of Rails and others. It's Rack-based, which means that it builds
on a middleware standard that is widely supported by Ruby hosters.
You'll see what I mean when we look at the code.

## Corkboard Server

Corkboard Server is a simple Sinatra app using Datamapper and SQLite that
allows the saving, updating and retrieval of simple 'notes'. It's intended
as an example for learning how to use Sinatra as a fast-to-make web app
approach for iOS developers. Corkboard Server goes with Corkboard client to
make a small, functional mobile application.

### Features

* Illustrates creation of an API with Sinatra
* Shows how to create a data model using Datamapper and SQLite
* Shows how to write tests for the web application

### Install

You'll need Ruby 2.3.3 to run, and Bundler to install the necessary gems.

    $ bundle
    $ rackup
    >> Thin web server (v1.7.0 codename Knife)
    >> Maximum connections set to 1024
    >> Listening on 0.0.0.0:9292, CTRL+C to stop

Your simple corkboard server is now running on port 9292 on your local machine.

### Running the tests

Once you have the code installed, running the tests is a simple as

    $ bundle
    $ bundle exec ruby tests/corkboard_test.rb

Running the tests will produce a test coverage file `coverage/index.html` which shows
all the pieces of code that were hit during the test run.

### API

This example code has a simple API for creating, updating and deleting 'notes'.

*Add a note to the database:*

    $ curl -X PUT -d '{"subject": "bacon", "content": "chunky"}' http://localhost:9292/note


if you get a 400 back, it means that you missed out on sending the right JSON. If you get a 201, then look for a single string in the response body - it will be the id of the note that was just created. You can use the id in the GET to retrieve what you just created.

*Retrieve a note from the database:*

    $ curl -X GET http://localhost:9292/note/1

returns JSON representation of note with id '1':

    {
       "subject" :  "Wibble wibble",
       "content" :  "Must dismantle wardrobe in spare room",
       "date"    :  "2017-01-24T13:36:12+00:00"
    }

The marshalling code for the Note is embedded in the Note model class, it's cunningly stored in a to_json method. If the note isn't in the database, you'll get a 404. A 200 means go unmarshal the JSON returned.


*Updating a note in the database:*

    $ curl -X POST -d "subject=wibble&content=chunky" http://localhost:9292/note/1

will update the content of note 1. If you get a 404, there isn't a note 1. If you get a 400, then you haven't given any arguments in the body of the request, i.e. changes to be made to the note. It should be along the lines of


    {
       "subject" :  "Wibble wibble",
       "content" :  "Must dismantle wardrobe in spare room",
    }

or even

    {
       "subject" :  "Wibble wibble",
    }

or

    {
       "content" :  "Must dismantle wardrobe in spare room",
    }

i.e., you can change the subject or the content. Any other stuff in the request will be ignored if it is not understood.

If you get a 500, then the database hasn't managed to save the update. Doh. You are looking for a 200 here to say everything is fine.

*Deleting a note from the database:*

    curl -X DELETE http://localhost:9292/note/1

Will remove note 1 from the database. If you are running this little example thru a webserver, and there is no reason why you should, so don't, then you might have an issue because many webservers aren't configured by default to DELETEs and even PUTs. You can workaround this by using a POST with an _method parameter on Rails and some other platforms, but for this trivial example, don't bother. Just run it natively as instructed.

If you get a 204 back, the note is gone. If you get a 404 back, then that note has been gone already. If you get a 500, then the database destroy operation failed, ho hum.
