require_relative '../app'

app = Sinatra::Application

posts = app.settings.tumblr_search.get
data = posts.collect {|post|
  related = case post["type"]
  when "video"
    {
      caption: post["caption"],
      embed: post["player"][0]["embed_code"]
    }
  when "audio"
    {
      caption: post["caption"],
      embed: post["embed"]
    }
  when "chat"
    {
      body: post["body"]
    }
  when "link"
    {
      title: post["title"],
      url: post["url"],
      description: post["description"]
    }
  when "quote"
    {
      text: post["text"],
      source: post["source"]
    }
  when "photo"
    photos = post["photos"].collect do |photo|
      {
        width: photo["original_size"]["width"],
        height: photo["original_size"]["height"],
        src: photo["alt_sizes"][-4]["url"],
        url: photo["original_size"]["url"]
      }
    end
    {
      photos: photos,
      caption: post["caption"]
    }
  when "text"
    {
        title: post["title"],
        body: post["body"]
    }
  end
  {
    service: "tumblr",
    uri: post["post_url"],
    type: "post-#{post["type"]}",
    related: related,
    created_at: DateTime.parse(post["date"]),
    tags: post["tags"]
  }
}

app.settings.cache.set 'posts', data