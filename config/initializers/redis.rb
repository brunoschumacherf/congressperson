if Rails.env.prodction?
  $redis = Redis.new(url: env['REDIS_URL'])
else
  redis_config = YAML.load(File.open(Rails.root.join('config/redis.yml'))).symbolize_keys[Rails.env.to_sym]
  $redis = Redis.new(redis_config)
end