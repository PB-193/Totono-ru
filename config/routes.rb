Rails.application.routes.draw do
  # ユーザ用
  # 新規投稿とログイン
  devise_for :users, controllers: {
    registrations: "user/registrations",
    sessions: 'user/sessions'
  }
  # namespaceをURLで使わない
  scope module: :user do
    # 投稿とタグとコメント
    resources :contents do
      resources :tags, only: [:new, :create, :destroy]
      resources :comments, only: [:new, :create, :destroy]
    end
    # マイページ
    resources :users, only: [:show, :edit, :update] do
      member do
        get :finalcheck
        delete :unsubscribe
      end
    end

  end
  
  # 管理者用
  # 管理者のログイン
  devise_for :admin, controllers: {
    sessions: "admin/sessions"
  }
  # ユーザ、投稿、タグの管理
  namespace :admin do
    resources :users, only: [:index, :show, :edit, :update]
    resources :tags, only: [:index, :create, :destroy]
    resources :contents, only: [:show, :destroy]
    get 'homes/top'
  end
  
  root to: "user/homes#top"

end
