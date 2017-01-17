Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'stream#index'

  scope module: :api, format: 'json' do
    namespace :v1 do
      get 'stream' => 'stream#stream'
      post 'message' => 'stream#message'
      resources :lounges, module: :lounges, shallow: true, only: [:index, :show, :create, :update, :destroy] do
        resources :attendees, only: [:index, :show, :create, :update, :destroy]
        resources :channels, module: :channels, only: [:index, :show, :create, :update, :destroy] do
          resources :attendees, path: :channel_attendees, only: [:index, :show, :create, :update, :destroy]
          resources :messages, only: [:index, :show, :create, :update, :destroy]
        end
      end
    end
  end

  resources :lounges do
    resources :lounges, module: :lounges, shallow: true, only: [:index, :show, :create, :update, :destroy] do
      resources :attendees, only: [:index, :show, :create, :update, :destroy]
      resources :channels, module: :channels, only: [:index, :show, :create, :update, :destroy] do
        resources :attendees, path: :channel_attendees, only: [:index, :show, :create, :update, :destroy]
        resources :messages, only: [:index, :show, :create, :update, :destroy]
      end
    end
  end

end
