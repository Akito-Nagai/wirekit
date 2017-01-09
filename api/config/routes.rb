Rails.application.routes.draw do

  scope module: :api, format: 'json' do
    namespace :v1 do
      get 'stream' => 'stream#index'
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
