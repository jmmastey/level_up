LevelUpRails
=========

An app to store and verify training material for engineers on the [Rails Prime Stack](http://words.steveklabnik.com/rails-has-two-default-stacks). Currently hosted at http://leveluprails.com.

Getting Started
---------------

Clone the repo, bundle install, create db, run rake to test. Deploy at will.
There is a Procfile provided for foreman. Feel free to create a `.env` file
for the environment. Some content modules may not be stored in source control
for competitive purposes.

    bundle install
    bundle exec rake db:{setup,seed}
    foreman start

Proprietary Content Support
---------------------------

LevelUp now supports proprietary courses for users from organizations. While the intention is to share as much as possible, it's useful to have one platform that also covers internal projects. the production site uses private gems with Rails Engines to mount the additional content. Users, courses, and categories can all have organization flags on them, which render them invisible to anyone outside those orgs.

Contributing
------------

Contributions are very welcome. Fork, fix, submit pulls.

Contribution is expected to conform to the [Contributor Covenant](https://github.com/jmmastey/level_up/blob/master/CODE_OF_CONDUCT.md).

Credits
-------

See [the humans file](public/humans.txt)

License
-------

This software is released under the [MIT License](https://github.com/jmmastey/level_up/blob/master/MIT-LICENSE).
