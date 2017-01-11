class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def redis
    @redis ||= Redis.new(url: "#{Settings.redis.endpoint}/stream")
  end

end
