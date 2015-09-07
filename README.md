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

See [the humans file](public/humans.txt) for information on helpful humans.

Some icons are used via the Noun Project. We bought a license but here's attribution anyway, because we like them:
- [Map](https://thenounproject.com/term/map/96666/), by Lloyd Humphreys, DK
- [Quiz](https://thenounproject.com/term/quiz/117740/), by carlos sarmento
- [Books](https://thenounproject.com/term/books/137857/), by Jakub Čaja
- [Signpost](https://thenounproject.com/term/signpost/116372/), by Creative Stall

License
-------

This software is released under the [MIT License](https://github.com/jmmastey/level_up/blob/master/MIT-LICENSE).
