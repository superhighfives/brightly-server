require_relative '../app'

app = Sinatra::Application

posts = app.settings.tumblr_search.get
data = posts.collect {|post|
  {
    service: "tumblr",
    uri: post["blog_name"],
    created_at: DateTime.parse(post["date"]),
    tags: post["tags"]
  }
}

app.settings.cache.set 'posts', data