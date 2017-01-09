require 'rails_helper'

RSpec.describe 'lounges', type: :request do
  include RequestHelper

  let(:article_structure) do
    {
      'id' => a_kind_of(String),
      'name' => a_kind_of(String),
      'description' => a_kind_of(String),
      'created_at' => a_kind_of(String),
      'updated_at' => a_kind_of(String),
      '_links' => a_kind_of(Hash)
    }
  end

  let(:lounge) { FactoryGirl.create(:lounge) }

  describe 'GET /v1/lounges' do
    it 'ラウンジ一覧を取得', autodoc: true do
      get "/v1/lounges", params, env
      expect(response).to have_http_status(200)
      expect(JSON(response.body)).to be_an_instance_of(Array)
      #      expect(JSON(response.body)).to match(article_structure)
    end
  end

end
