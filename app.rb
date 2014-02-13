require 'sinatra'
require 'sinatra/cross_origin'
require 'sinatra/jsonp'
require 'dalli'
require 'json'
require 'newrelic_rpm'

require 'twitter'
require 'twitter-text'
require 'tumblr_client'
require 'songkickr'
require 'soundcloud'
require 'instagram'

#libraries
require_relative './lib/twitter_search'
require_relative './lib/tumblr_search'
require_relative './lib/songkick_search'
require_relative './lib/soundcloud_search'
require_relative './lib/instagram_search'
require_relative './lib/cache'

require_relative './lib/config'

configure :development do
  # Fix thin logging
  $stdout.sync = true
  require 'sinatra/reloader'
  set :allow_origin, '*'
end

helpers do
  def cache
    settings.cache
  end
  def twitter_search
    settings.twitter_search
  end
  def tumblr_search
    settings.tumblr_search
  end
  def songkick_search
    settings.songkick_search
  end
  def soundcloud_search
    settings.soundcloud_search
  end
  def instagram_search
    settings.instagram_search
  end
end

get '/latest_gig.json' do
  content_type :json
  results = cache.get('gigs')
  jsonp results.first
end

get '/gigs.json' do
  content_type :json
  results = cache.get('gigs')
  jsonp results
end

get '/tweets.json' do
  content_type :json
  tweets = cache.get('tweets')
  jsonp tweets
end

get '/posts.json' do
  content_type :json
  posts = cache.get('posts')
  jsonp posts
end

get '/tracks.json' do
  content_type :json
  tracks = cache.get('tracks')
  jsonp tracks
end

get '/snaps.json' do
  content_type :json
  snaps = cache.get('snaps')
  jsonp snaps
end

get '/feeds.json' do
  content_type :json
  
  # posts = cache.get('posts')
  # tracks = cache.get('tracks')
  tweets = cache.get('tweets')
  snaps = cache.get('snaps')
  
  # feeds = tweets + posts + tracks + snaps
  feeds = tweets + snaps

  # sorted_feeds = feeds.sort_by{ |item| item[:created_at] }.reverse
  sorted_feeds = feeds.shuffle
  jsonp sorted_feeds
end