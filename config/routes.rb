Rails.application.routes.draw do
  
  # 利用規約
  get 'terms_of_use', to: 'homes#terms_of_use'
  # プライバシーポリシー
  get 'privacy_policy', to: 'homes#privacy_policy'
  
  root to: "homes#top"
  #　ゲストログイン用
  post "/homes/guest_sign_in", to: "homes#guest_sign_in"
  
  draw :admin
  draw :user
  
end
