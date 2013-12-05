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

#libraries
require_relative './lib/twitter_search'
require_relative './lib/tumblr_search'
require_relative './lib/songkick_search'
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

get '/feeds.json' do
  content_type :json
  
  tweets = cache.get('tweets')
  posts = cache.get('posts')
  
  feeds = tweets + posts

  sorted_feeds = feeds.sort_by{ |item| item[:created_at] }.reverse
  jsonp sorted_feeds
end