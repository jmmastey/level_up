level_up
=========

An app to store and verify training material for engineers on the [Rails Prime Stack](http://words.steveklabnik.com/rails-has-two-default-stacks). Currently hosted at http://leveluprails.herokuapp.com.

Getting Started
---------------

Clone the repo, run rake to test. Deploy at will. Some content modules
may not be stored in source control for competitive purposes.

## Configuring

### .env
Copy the /.env.example into a new /.env file (which is in .gitignore) and fill in with your settings.


### Devise secret_key
You will also need to uncomment /config/initializers/devise.rb 'secret_key'

```ruby
config.secret_key = 'f6a7f92d27a0a5a43bd2b10b1b4c1c56313acd913ed1ab2e35b'
```

### Database

Copy /config/database.yml.example into a new database.yml (which is in .gitignore) and fill in with your settings.

### Final steps

TODO
- bundle install
- bundle exec rake db:create
- bundle exec rake db:setup
- TODO....

Contributing
------------

Contributions are very welcome. Fork, fix, submit pulls.

Credits
-------

See [the humans file](public/humans.txt)

License
-------

levelup is released under the [MIT License](https://github.com/jmmastey/levelup/blob/master/MIT-LICENSE).
