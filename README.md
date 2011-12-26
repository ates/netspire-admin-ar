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
* Run application development mode
<pre>
    $ bundle exec rails server
</pre>

Rake tasks
----------

* Create new domain
<pre>
    $ bundle exec rake netspire:domains:create NAME=myisp TITLE=MyISP
</pre>
* Create new admin account with all permissions and assinged to specific domain
<pre>
    $ bundle exec rake netspire:admins:create LOGIN=admin PASSWORD=secret DOMAIN=myisp
    Authentication token is uxsrYB4bSBgDeZ65jmaq
</pre>
