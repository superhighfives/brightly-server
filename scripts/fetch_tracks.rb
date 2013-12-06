require_relative '../app'

app = Sinatra::Application

tracks = app.settings.soundcloud_search.get
data = tracks.collect {|track|
  {
    service: "soundcloud",
    artwork_url: track.artwork_url,
    playback_count: track.playback_count,
    purchase_url: track.purchase_url,
    title: track.title,
    kind: track.kind,
    id: track.id,
    uri: track.permalink_url,
    created_at: DateTime.parse(track.created_at)
  }
}

app.settings.cache.set 'tracks', data