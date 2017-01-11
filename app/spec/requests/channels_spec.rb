require 'rails_helper'

RSpec.describe 'channels', type: :request do

  let(:channel_structure) do
    {
      'id' => a_kind_of(String),
      'name' => a_kind_of(String),
      'description' => a_kind_of(String).or(a_nil_value),
      'created_at' => a_kind_of(String),
      'updated_at' => a_kind_of(String),
      '_links' => a_kind_of(Hash)
    }
  end

  describe 'GET /v1/lounges/:lounge_id/channels' do
    it 'チャンネル一覧を取得', autodoc: true do
      FactoryGirl.create(:channel)
      get "/v1/lounges"
      lounge = JSON(response.body).first
      get lounge['_links']['channels']['href']
      expect(response).to have_http_status(200)
      data = JSON(response.body)
      expect(data).to be_an_instance_of(Array)
      expect(data.first).to match(channel_structure)
    end
  end

end
