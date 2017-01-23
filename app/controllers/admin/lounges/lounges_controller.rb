class Admin::Lounges::LoungesController < ApplicationController

  def index
    @title = 'Lounges'
  end

  def show
    res = backend.get("/v1/lounges/#{params[:id]}")
    @lounge = res.body
    @lounge_uuid = @lounge[:id]
    @title = @lounge[:name]
  end

end
