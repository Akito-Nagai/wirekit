class Admin::Lounges::LoungesController < ApplicationController

  def index
    @title = 'Lounges'
    res = backend.get("/v1/lounges")
    @lounges = res.body
  end

  def show
    res = backend.get("/v1/lounges/#{params[:id]}")
    @lounge = res.body
    @title = @lounge[:name]
    res = backend.get(@lounge[:_links][:channels][:href])
    @channels = res.body
  end

  private

  def backend
    @backend ||= Faraday.new(url: Settings.backend.endpoint) do |faraday|
      faraday.request  :url_encoded
      faraday.response :logger
      faraday.response :symbolized_json
      faraday.adapter  :net_http
    end
  end

end
