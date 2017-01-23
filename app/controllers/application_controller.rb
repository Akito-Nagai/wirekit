class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private

  def redis
    @redis ||= Redis.new(url: "#{Settings.redis.endpoint}/stream")
  end

  def backend
    @backend ||= Faraday.new(url: Settings.backend.endpoint) do |faraday|
      faraday.request  :url_encoded
      faraday.response :logger
      faraday.response :symbolized_json
      faraday.adapter  :net_http
    end
  end

end
