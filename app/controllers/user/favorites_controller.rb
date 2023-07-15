class User::FavoritesController < ApplicationController
  before_action :guest_check, only: [:new, :create]
  
  def create
    @content = Content.find(params[:content_id])
    favorite = current_user.favorites.new(content_id: @content.id)
    favorite.save
  end

  def destroy
    @content = Content.find(params[:content_id])
    favorite = current_user.favorites.find_by(content_id: @content.id)
    favorite.destroy
  end
  
  def guest_check
    if current_user.email == 'guest@example.com'
      redirect_to request.referer, alert: "いいねをするにはユーザ登録が必要です。"
    end
  end
  
end
