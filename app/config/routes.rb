Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get 'stream/index'     # チャット画面表示
  get 'stream/stream'    # SSE接続
  post 'stream/message'  # コメント受付

end
