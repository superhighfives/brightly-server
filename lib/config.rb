set :tumblr_search, TumblrSearch.new(
  ::Tumblr::Client.new(consumer_key: ENV['TUMBLR_CONSUMER_KEY'],
                       consumer_secret: ENV['TUMBLR_CONSUMER_SECRET'])
)

set :twitter_search, TwitterSearch.new(
  ::Twitter::REST::Client.new(consumer_key: ENV['TWITTER_CONSUMER_KEY'],
                              consumer_secret: ENV['TWITTER_CONSUMER_SECRET'],
                              access_token: ENV['TWITTER_OAUTH_TOKEN'],
                              access_token_secret: ENV['TWITTER_OAUTH_TOKEN_SECRET'])
)

set :songkick_search, SongkickSearch.new(
  ::Songkickr::Remote.new(ENV['SONGKICK_KEY'])
)

set :soundcloud_search, SoundcloudSearch.new(
  ::SoundCloud.new(client_id: ENV['SOUNDCLOUD_CLIENT_ID'],
                   client_secret: ENV['SOUNDCLOUD_CLIENT_SECRET'])
)

set :instagram_search, InstagramSearch.new(
  ::Instagram::Client.new(client_id: ENV['INSTAGRAM_CLIENT_ID'],
                   client_secret: ENV['INSTAGRAM_CLIENT_SECRET'],
                   access_token: ENV['INSTAGRAM_ACCESS_TOKEN'])
)

set :cache, Cache.new(
  ::Dalli::Client.new(ENV['MEMCACHIER_SERVERS'].split(','),
                      username: ENV['MEMCACHIER_USERNAME'],
                      password: ENV['MEMCACHIER_PASSWORD'],
                      namespace: 'brightly')
)