class TumblrSearch

  SEARCH_RETRY_ATTEMPTS = 3

  def initialize(tumblr_client)
    @client = tumblr_client
  end

  def get
    log "Searching Tumblr..."
    attempts = 1
    begin
      log "Success!"
      data = @client.posts("dummydummydummydummydummy.tumblr.com")
      data["posts"]
    rescue
      log "Tumblr returned an error"
      if attempts <= SEARCH_RETRY_ATTEMPTS
        puts "Attempt #{attempts}. Retrying..."
        attempts += 1
        retry
      else
        puts "#{attempts} failed attempts. Giving up on Tumblr search."
        []
      end
    end
  end

  def log(m)
    puts "[TumblrSearch] #{m}"
  end

end