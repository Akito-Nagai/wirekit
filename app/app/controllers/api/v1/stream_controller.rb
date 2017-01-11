class Api::V1::StreamController < ApplicationController

  def index
  end

  def stream
    response.headers['Content-Type'] = 'text/event-stream'
    redis.subscribe('messages.create') do |on|
      on.message do |event, data|
        response.stream.write("data: #{data}\n\n")
      end
    end
  rescue IOError
    logger.info 'Stream closed'
  rescue ActionController::Live::ClientDisconnected
    logger.info 'Client disconnected'
  ensure
    response.stream.close
  end

  def message
    redis.publish('messages.create', params[:comment].to_json)
    render text: nil
  end

  private

  def redis
    @redis ||= Redis.new(url: "#{Settings.redis.endpoint}/stream")
  end

end
