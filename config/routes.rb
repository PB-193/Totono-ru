Rails.application.routes.draw do
  namespace :admin do
    get 'users/index'
    get 'users/show'
    get 'users/edit'
  end
  namespace :admin do
    get 'tags/index'
  end
  namespace :admin do
    get 'contents/show'
  end
  namespace :admin do
    get 'homes/top'
  end
  namespace :user do
    get 'homes/top'
  end
  namespace :user do
    get 'tags/new'
  end
  namespace :user do
    get 'comments/new'
  end
  namespace :user do
    get 'contents/index'
    get 'contents/show'
    get 'contents/new'
    get 'contents/edit'
  end
  namespace :user do
    get 'users/show'
    get 'users/edit'
    get 'users/finalcheck'
  end
  # 顧客用
  # URL /customers/sign_in ...
  devise_for :users, controllers: {
    registrations: "user/registrations",
    sessions: 'user/sessions'
  }
  
  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, controllers: {
    sessions: "admin/sessions"
  }
  
  
  
  root to: "homes#top"
end
