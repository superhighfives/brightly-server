class Cache

  def initialize(memcached_client)
    @client = memcached_client
  end
  
  def get(type)
    @client.get cache_key(type)
  end

  def set(type, data)
    @client.set cache_key(type), data
  end

  def delete(type)
    @client.delete cache_key(type)
  end

  def cache_key(type)
    type.to_s
  end

end