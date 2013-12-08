class InstagramSearch

  SEARCH_RETRY_ATTEMPTS = 3

  def initialize(instagram_client)
    @client = instagram_client
  end

  def get
    log "Searching Instagram..."
    attempts = 1
    begin
      log "Success!"
      @client.user_recent_media
    rescue
      log "Instagram returned an error"
      if attempts <= SEARCH_RETRY_ATTEMPTS
        puts "Attempt #{attempts}. Retrying..."
        attempts += 1
        retry
      else
        puts "#{attempts} failed attempts. Giving up on Instagram search."
        []
      end
    end
  end

  def log(m)
    puts "[Instagram Search] #{m}"
  end

end