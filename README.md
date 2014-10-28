level_up
=========

An app to store and verify training material for engineers on the [Rails Prime Stack](http://words.steveklabnik.com/rails-has-two-default-stacks). Currently hosted at http://leveluprails.herokuapp.com.

Getting Started
---------------

Clone the repo, bundle install, create db, run rake to test. Deploy at will.
There is a Procfile provided for foreman. Feel free to create a `.env` file
for the environment. Some content modules may not be stored in source control
for competitive purposes.

    bundle install
    bundle exec rake db:{setup,seed}
    foreman start

Contributing
------------

Contributions are very welcome. Fork, fix, submit pulls.

Credits
-------

See [the humans file](public/humans.txt)

License
-------

levelup is released under the [MIT License](https://github.com/jmmastey/levelup/blob/master/MIT-LICENSE).
