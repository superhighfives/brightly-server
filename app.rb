require 'sinatra'
require 'sinatra/cross_origin'
require 'sinatra/jsonp'
require 'dalli'
require 'json'
require 'newrelic_rpm'

require 'twitter'

#libraries
require_relative './lib/twitter_search'

set :twitter_search, TwitterSearch.new

configure :development do
  # Fix thin logging
  $stdout.sync = true
  require 'sinatra/reloader'
  set :allow_origin, '*'
end

helpers do
  def twitter_search
    settings.twitter_search
  end
end

get '/data.json' do
  content_type :json
  tweets = settings.twitter_search.getTweets
  results = tweets
  jsonp results
end