class SongkickSearch

  SEARCH_RETRY_ATTEMPTS = 3

  def initialize(songkick_client)
    @client = songkick_client
  end

  def get
    log "Searching Songkick..."
    attempts = 1
    begin
      log "Success!"
      @client.events(artist_name: 'Brightly').results
    rescue
      log "Songkick returned an error"
      if attempts <= SEARCH_RETRY_ATTEMPTS
        puts "Attempt #{attempts}. Retrying..."
        attempts += 1
        retry
      else
        puts "#{attempts} failed attempts. Giving up on Songkick search."
        []
      end
    end
  end

  def log(m)
    puts "[SongkickSearch] #{m}"
  end

end