class Api::V1::StreamController < ApplicationController
  include ActionController::Live

  before_action :close_db_connection

  def stream
    logger.info 'Stream open'
    response.headers['Content-Type'] = 'text/event-stream'
    redis = Redis.new(url: "#{Settings.redis.endpoint}/stream")
    listens = listen_channels
    sender = Thread.new do
      logger.info "Subscribe redis: #{listens.inspect}"
      redis.subscribe(listens) do |on|
        on.message do |event, data|
          response.stream.write("data: #{data}\n\n")
        end
      end
    end
    loop do
      response.stream.write(":ping\n\n")
      sleep 10
    end
  rescue IOError, ActionController::Live::ClientDisconnected
    logger.info $!.to_s
  ensure
    logger.info 'Stream closed'
    sender.kill
    redis.quit
    response.stream.close
  end

  private

  def listen_channels
    channels = ['public']
    channels << "lounge-#{params[:lounge]}" if params[:lounge].present?
    channels << "channel-#{params[:channel]}" if params[:channel].present?
    channels << "attendee-#{params[:attendee]}" if params[:attendee].present?
    channels
  end

  def close_db_connection
    ActiveRecord::Base.connection_pool.release_connection
  end

end
