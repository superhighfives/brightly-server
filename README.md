# Brightly Server

The server that powers the [Brightly](https://github.com/superhighfives/brightly) site.

## Fire it up

Before you start, you'll need to make sure you edit the `sample.env` and save it as `.env` with the appropriate keys.

1. If you don't have Memcache run `brew install memcached` and start it with `memcached &`
2. Run `bundle install`
3. Make sure you've got the [Heroku Toolbelt](https://toolbelt.heroku.com/)
4. Run `foreman start web`
