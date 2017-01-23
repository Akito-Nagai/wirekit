class Api::V1::StreamController < ApplicationController
  include ActionController::Live

  def stream
    response.headers['Content-Type'] = 'text/event-stream'
    redis.subscribe('messages.create') do |on|
      on.message do |event, data|
        response.stream.write("data: #{data}\n\n")
      end
    end
    redis.subscribe('global') do |on|
      on.message do |event, data|
        response.stream.write("data: #{data}\n\n")
      end
    end
    redis.subscribe('lounge') do |on|
      on.message do |event, data|
        response.stream.write("data: #{data}\n\n")
      end
    end
    redis.subscribe('channel') do |on|
      on.message do |event, data|
        response.stream.write("data: #{data}\n\n")
      end
    end
    redis.subscribe('attendee') do |on|
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

  def knock
  end

end
