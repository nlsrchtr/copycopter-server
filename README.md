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

In the ```Gemfile``` remove the database connectors you dont't need.

Install dependencies
--------------------

    bundle install

Adding a Project
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

Deploy to Heroku
----------------

Deploy Copycopter Server like any other Rails app.

    heroku create --stack cedar
    git push heroku master
    heroku run rake db:migrate
    heroku restart

Contribute
----------

See the [style guide](https://github.com/copycopter/style-guide).

Set up dependencies:

    bundle

Run the test suite:

    bundle exec rake

Run the server:

    foreman start

Automatically regenerate CSS when you edit Sass files:

    sass --watch public/stylesheets/sass:public/stylesheets \
      -r ./public/stylesheets/sass/bourbon/lib/bourbon.rb

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
