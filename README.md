Copycopter
==========

[![Build Status](https://secure.travis-ci.org/copycopter/copycopter-server.png)](http://travis-ci.org/copycopter/copycopter-server)

Copycopter is a service for editing the copy text of a Rails application.

Each Rails application has its own Project, connected by an API key.
Each piece of copy in a Project is a Blurb. Each Blurb has many Versions, which
track changes users make to copy.

Each Version is either draft or published. The most typical scenario is to
display published content in production, and draft in all other environments.

A developer can issue a deploy, which marks the latest Version of all Blurbs as
published.

Get your copy
-------------

    git clone git://github.com/copycopter/copycopter-server.git
    cd copycopter-server

Set up database
---------------

For MySQL support:

    cp config/database.mysql.yml config/database.yml

For PostgreSQL support:

    cp config/database.postgres.yml config/database.yml

For SQLite3 support:

    cp config/database.sqlite.yml config/database.yml

Add your connection details to ```config/database.yml```.

In the ```Gemfile``` remove the database connectors you don't need.

Install dependencies
--------------------

    bundle install

Adding a project
----------------

    bundle exec rake copycopter:project NAME=Iora USERNAME=Copy PASSWORD=Copter

or at Heroku
    
    heroku run rake copycopter:project NAME=Iora USERNAME=Copy PASSWORD=Copter


Updating a projects password
----------------------------
    
    bundle exec rake copycopter:change_project_password NAME=IORA OLD=Copter NEW=COPTAH

or at Heroku

    heroku run rake copycopter:change_project_password NAME=IORA OLD=Copter NEW=COPTAH

Removing a project
------------------

    bundle exec rake copycopter:remove_project NAME=Iora

or at Heroku

    heroku run rake copycopter:remove_project NAME=Iora

Deploy
------

Deploy Copycopter Server like any other Rails app.

with Capistrano

1. Create your own deploy.rb: ````cp config/deploy.example.rb config/deploy.rb````
2. Change ````config/deploy.rb```` to your own needs
3. Take care to include a ````config/database.yml```` into your deployment
4. Run the deploy setup: ````cap deploy:setup````
5. Run initial deployment: ````cap deploy````
6. Migrate the database: ````cap deploy:migrate````

to Heroku

1. Create your own app: ````heroku create --stack cedar````
2. Push the code to Heroku: ````git push heroku master````
3. Migrate the database: ````heroku run rake db:migrate````
4. Restart your app: ````heroku restart````

Contribute
----------

1. See the [style guide](https://github.com/copycopter/style-guide).
2. Set up dependencies: ````bundle````
3. Run the test suite: ````bundle exec rake````
4. Make sure all tests are passed

Credits
-------

![thoughtbot](http://thoughtbot.com/images/tm/logo.png)

Copycopter Server was created by [thoughtbot, inc](http://thoughtbot.com)

It is maintained by the fine folks at [Crowdtap](http://crowdtap.com) and
[Iora Health](http://iorahealth.com).

License
-------

Copycopter Server is free software, and may be redistributed under the terms
specified in the MIT-LICENSE file.
