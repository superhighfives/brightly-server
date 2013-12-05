class SongkickSearch

  SEARCH_RETRY_ATTEMPTS = 3

  def get
    log "Searching Songkick..."
    attempts = 1
    songkick = Songkickr::Remote.new ENV['SONGKICK_KEY']
    begin
      log "Success!"
      songkick.events(artist_name: 'Brightly').results
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