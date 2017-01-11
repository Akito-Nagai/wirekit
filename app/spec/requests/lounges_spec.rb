require 'rails_helper'

RSpec.describe 'lounges', type: :request do

  let(:lounge_structure) do
    {
      'id' => a_kind_of(String),
      'name' => a_kind_of(String),
      'description' => a_kind_of(String).or(a_nil_value),
      'created_at' => a_kind_of(String),
      'updated_at' => a_kind_of(String),
      '_links' => a_kind_of(Hash)
    }
  end

  describe 'GET /v1/lounges' do
    it 'ラウンジ一覧を取得', autodoc: true do
      FactoryGirl.create(:lounge)
      get "/v1/lounges"
      expect(response).to have_http_status(200)
      data = JSON(response.body)
      expect(data).to be_an_instance_of(Array)
      expect(data.first).to match(lounge_structure)
    end
  end

end
