$redis = Redis.new

url = "redis://:p2339f3dc0a1795efdd62d8609688c70f48e1ab493a4d35174638a1a4bc7ba85e@ec2-44-208-7-5.compute-1.amazonaws.com:8019"

if url
  Sidekiq.configure_server do |config|
    config.redis = { url: url }
  end

  Sidekiq.configure_client do |config|
    config.redis = { url: url }
  end
  $redis = Redis.new(:url => url)
end
