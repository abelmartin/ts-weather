require "redis"

# Simple global redis connection
redis_url = ENV['UPSTASH_REDIS_URL'] || 'redis://localhost:6379/0'
$redis = Redis.new(url: redis_url)
