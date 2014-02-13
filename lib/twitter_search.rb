class TwitterSearch

  SEARCH_RETRY_ATTEMPTS = 3

  def initialize(twitter_client)
    @client = twitter_client
  end

  def get
    log "Searching Twitter..."
    attempts = 1
    options = {limit: 5, include_rts: true, exclude_replies: true, include_entities: true}
    begin
      log "Success!"
      @client.user_timeline("wearebrightly", options)
    rescue Twitter::Error => e
      log "Twitter returned an error: #{e.inspect}"
      if attempts <= SEARCH_RETRY_ATTEMPTS
        puts "Attempt #{attempts}. Retrying..."
        attempts += 1
        retry
      else
        puts "#{attempts} failed attempts. Giving up on Twitter search."
        []
      end
    end
  end

  def log(m)
    puts "[TwitterSearch] #{m}"
  end

end