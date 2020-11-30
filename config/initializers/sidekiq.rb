Sidekiq.configure_server do |config|
  config.redis = { url: "redis://#{Settings.redis.host}:#{Settings.redis.port}", namespace: Settings.redis.namespace }
end

Sidekiq.configure_client do |config|
  config.redis = { url: "redis://#{Settings.redis.host}:#{Settings.redis.port}", namespace: Settings.redis.namespace }
end
