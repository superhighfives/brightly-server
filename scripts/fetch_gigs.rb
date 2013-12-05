require_relative '../app'

app = Sinatra::Application

gigs = app.settings.songkick_search.get
data = gigs.collect {|gig|

  bands = gig.performances.collect {|performance|
    {
      name: performance.artist.display_name,
      uri: performance.artist.uri
    }
  }

  {
    service: "songkick",
    uri: gig.uri,
    created_at: gig.start,
    city: {
      name: gig.location.city,
      latitude: gig.location.lng,
      longitude: gig.location.lat
    },
    venue: {
      name: gig.venue.display_name,
      latitude: gig.venue.lng,
      longitude: gig.venue.lat
    },
    bands: bands
  }
}

app.settings.cache.set 'gigs', data