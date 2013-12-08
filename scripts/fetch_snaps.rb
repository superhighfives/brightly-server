require_relative '../app'

app = Sinatra::Application

snaps = app.settings.instagram_search.get
data = snaps.collect {|snap|

  src = case snap.type
  when "image"
    snap.images.standard_resolution.url
  end
  {
    service: "instagram",
    type: snap.type,
    src: src,
    caption: snap.caption.text,
    likes: snap.likes["count"],
    created_at: Time.at(snap.created_time.to_i).utc.to_datetime,
    uri: snap.link
  }
}

app.settings.cache.set 'snaps', data