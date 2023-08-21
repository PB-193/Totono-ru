Rails.application.routes.draw do

  get 'terms_of_use', to: 'homes#terms_of_use'
  get 'privacy_policy', to: 'homes#privacy_policy'

  namespace :user do
    get 'favorites/create'
    get 'favorites/destroy'
  end
  # ユーザ用
  # 新規投稿とログイン
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

  
  # 管理者用
  # 管理者のログイン
  devise_for :admin, controllers: {
    sessions: "admin/sessions"
  }
  namespace :admin do
    resources :users, only: [:index, :show, :edit, :update, :destroy] 
    resources :tags, only:[:index] do
      collection do
        post :create
        delete :delete
      end
    end
    resources :contents, only: [:show, :update , :destroy]
    get 'homes/top'
    get 'tests/show'
  end
  
  root to: "homes#top"
  #　ゲストログイン用
  post "/homes/guest_sign_in", to: "homes#guest_sign_in"
  
end
