$encryption_key_redis = ConnectionPool::Wrapper.new(size: ENV.fetch("REDIS_POOL", 5), timeout: 3) {
  Redis::Namespace.new(
    namespace_key, 
    redis: Redis.new(url: ENV.fetch("REDIS_HOST", "redis://localhost:6379/0")))
}

def namespace_key
  [Rails.env, :encrypt].join("_").to_sym
end
