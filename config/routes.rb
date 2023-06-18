Rails.application.routes.draw do
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
      resources :comments, only: [:new, :create, :destroy]
    end
    # 検索
    resources :searches, only: [:index] do
      get :find, on: :collection
    end
    # マイページ
    get 'user/mypage' => 'users#show', as: 'mypage'
    get 'user/information/edit' => 'users#edit', as: 'edit_information'
    patch 'user/information' => 'users#update', as: 'update_information'
    get 'user/finalcheck' => 'users#finalcheck', as: 'finalcheck'
    put 'user/information' => 'users#update'
    patch 'user/withdraw' => 'users#withdraw', as: 'withdraw_user'
  end

  
  # 管理者用
  # 管理者のログイン
  devise_for :admin, controllers: {
    sessions: "admin/sessions"
  }
  namespace :admin do
    resources :users, only: [:index, :show, :edit, :update] 
    resources :tags, only:[:index] do
      collection do
        post :create
        delete :delete
      end
    end
    resources :contents, only: [:show, :destroy]
    get 'homes/top'
  end
  
  root to: "homes#top"
  #　ゲストログイン用
  post "/homes/guest_sign_in", to: "homes#guest_sign_in"

end
