Web administration interface for Netspire
=========================================

Required software
-----------------

* Ruby 1.9 or higher
* Rubygems
* Rails 3.1.3

Running
-------

* cd netspire-admin
* copy config/database.yml.sample to config/database.yml
<pre>
    $ cp config/database.yml.sample config/database.yml
    $ ls -l config/database.yml
    -rw-r--r-- 1 user group 276 Dec  9 13:13 config/database.yml
</pre>
* Install required gems
<pre>
    $ bundle install
</pre>
* Bootstrap database
<pre>
    $ bundle exec rake db:setup
</pre>
* Run application
<pre>
    $ bundle exec rails server
</pre>
