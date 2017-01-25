$redis = Redis.new(url: "#{Settings.redis.endpoint}/stream")

heartbeat_thread = Thread.new do
  loop do
    $redis.publish('ping', 'ping')
    sleep 10
  end
end

at_exit do
  heartbeat_thread.kill
  $redis.quit
end
