class SoundcloudSearch

  SEARCH_RETRY_ATTEMPTS = 3

  def initialize(soundcloud_client)
    @client = soundcloud_client
  end

  def get
    log "Searching Soundcloud..."
    options = {limit: 5, filter: "public"}
    attempts = 1
    begin
      log "Success!"
      tracks = @client.get('/users/6553615/tracks', options)
    rescue
      log "SoundcloudSearch returned an error"
      if attempts <= SEARCH_RETRY_ATTEMPTS
        puts "Attempt #{attempts}. Retrying..."
        attempts += 1
        retry
      else
        puts "#{attempts} failed attempts. Giving up on Soundcloud search."
        []
      end
    end
  end

  def log(m)
    puts "[SoundcloudSearch] #{m}"
  end

end