class TwitterSearch

  SEARCH_RETRY_ATTEMPTS = 0

  def getTweets()
    log "Searching twitter..."
    attempts = 1
    begin
      Twitter.user_timeline("wearebrightly").collect { |tweet| tweet.attrs }
    rescue Twitter::Error::ClientError => e
      log "Twitter returned an error: #{e.inspect}"
      if attempts <= SEARCH_RETRY_ATTEMPTS
        puts "Attempt #{attempts}. Retrying..."
        attempts += 1
        retry
      else
        puts "#{attempts} failed attempts. Giving up on tweet search."
        []
      end
    end
  end

  def log(m)
    puts "[TwitterSearcher] #{m}"
  end

end