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
    resources :contents, only: [:index, :show, :update , :destroy] do
      collection do
        delete :delete
      end
    end
    get 'homes/top'
    get 'tests/show'
  end