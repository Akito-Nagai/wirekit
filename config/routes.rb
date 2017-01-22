Rails.application.routes.draw do

  use_doorkeeper

  root 'stream#index'

  scope module: :api, format: 'json' do
    namespace :v1 do
      root 'root#index'
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

  namespace :admin do
    resources :lounges, module: :lounges, shallow: true, only: [:index, :show, :create, :update, :destroy] do
      resources :attendees, only: [:index, :show, :create, :update, :destroy]
      resources :channels, module: :channels, only: [:index, :show, :create, :update, :destroy] do
        resources :attendees, path: :channel_attendees, only: [:index, :show, :create, :update, :destroy]
        resources :messages, only: [:index, :show, :create, :update, :destroy]
      end
    end
  end

end
