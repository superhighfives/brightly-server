require_relative '../app'

app = Sinatra::Application
include Twitter::Autolink
include Twitter::Extractor

tweets = app.settings.twitter_search.get
data = tweets.collect {|tweet|
  text = !tweet.retweeted ? tweet.text : tweet.retweeted_status.text
  tweet_attrs = !tweet.retweeted ? tweet.attrs[:entities] : tweet.retweeted_status.attrs[:entities]
  tweet_text = auto_link_with_json(text.dup, tweet_attrs)
  {
    service: "twitter",
    uri: "https://twitter.com/wearebrightly/status/#{tweet.attrs[:id_str]}",
    created_at: DateTime.parse(tweet.created_at.to_s),
    text: tweet_text,
    retweeted: tweet.retweeted,
    user: (!tweet.retweeted ? tweet.user.name : tweet.retweeted_status.user.name),
    screen_name: (!tweet.retweeted ? tweet.user.screen_name : tweet.retweeted_status.user.screen_name),
  }
}

app.settings.cache.set 'tweets', data