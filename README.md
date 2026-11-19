# Brightly server

A small API for the old site of my band, Brightly. It pulled gigs, tweets, Instagram photos, Tumblr posts and SoundCloud tracks from each service, cached them in Memcached, and served them to the site as JSON.

Status: archived. Made in 2013, last updated in 2015, and ran on Heroku. The site it served is [brightly-static](https://github.com/superhighfives/brightly-static). Brightly's site now lives at [wewerebrightly.com](https://wewerebrightly.com), and doesn't use this.

## Running it

You'll need Ruby, Bundler, Memcached, Foreman and API keys for each service. Most of these APIs have changed or shut down since, so it won't fetch much today.

```sh
cp sample.env .env                    # add your keys
memcached &
bundle install
foreman start web
foreman run ruby scripts/fetch.rb     # refresh the cache
```

## How it works

- `app.rb` is a Sinatra app with JSONP endpoints: `/gigs.json`, `/latest_gig.json`, `/tweets.json`, `/posts.json`, `/tracks.json`, `/snaps.json` and `/feeds.json`.
- `lib/config.rb` sets up a client for each service from environment variables. The `lib/*_search.rb` files wrap Songkick, Twitter, Instagram, Tumblr and SoundCloud, and `lib/cache.rb` wraps Memcached.
- `scripts/fetch.rb` runs the fetch scripts for gigs, tweets and Instagram photos and stores the results. The Tumblr and SoundCloud fetches are turned off, and `/feeds.json` only returns Instagram photos.
