Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get 'stream/index'     # チャット画面表示
  get 'stream/stream'    # SSE接続
  post 'stream/message'  # コメント受付

  scope module: :api, format: 'json' do
    namespace :v1 do
      get 'stream' => 'stream#stream'
      resources :lounges, module: :lounges, shallow: true do
        resources :attendees
        resources :channels, module: :channels do
          resources :attendees, path: :channel_attendees
          resources :messages
        end
      end
    end
  end

end
