  # ユーザ用
  # 新規投稿とログイン
  
  namespace :user do
    get 'favorites/create'
    get 'favorites/destroy'
  end

  devise_for :users, controllers: {
    registrations: "user/registrations",
    sessions: 'user/sessions'
  }
  
  scope module: :user do
    # 投稿とタグとコメント
    resources :contents do
      resources :tags, only: [:new, :create, :destroy]
      resources :comments, only: [:create, :destroy]
      resource :favorites,only:[:create,:destroy]
    end
    # 検索
    resources :searches, only: [:index] do
      get :find, on: :collection
    end
    # マイページ
    get 'user/finalcheck' => 'users#finalcheck', as: 'finalcheck'
    get 'user/myshow' => 'users#myshow', as: 'myshow'
    get 'user/:id' => 'users#show' , as: 'user'
    get 'user/information/edit' => 'users#edit', as: 'edit_information'
    patch 'user/information' => 'users#update', as: 'update_information'
    put 'user/information' => 'users#update'
    patch 'user/withdraw' => 'users#withdraw', as: 'withdraw_user'
  end
