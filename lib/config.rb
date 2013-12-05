set :songkick_search, SongkickSearch.new

set :tumblr_search, TumblrSearch.new(
  ::Tumblr::Client.new(consumer_key: ENV['TUMBLR_CONSUMER_KEY'],
                       consumer_secret: ENV['TUMBLR_CONSUMER_SECRET'],
  )
)

set :twitter_search, TwitterSearch.new(
  ::Twitter::REST::Client.new(consumer_key: ENV['TWITTER_CONSUMER_KEY'],
                              consumer_secret: ENV['TWITTER_CONSUMER_SECRET'],
                              access_token: ENV['TWITTER_OAUTH_TOKEN'],
                              access_token_secret: ENV['TWITTER_OAUTH_TOKEN_SECRET']
  )
)

set :cache, Cache.new(
  ::Dalli::Client.new(ENV['MEMCACHIER_SERVERS'].split(','),
                      username: ENV['MEMCACHIER_USERNAME'],
                      password: ENV['MEMCACHIER_PASSWORD'],
                      namespace: 'brightly')
)