class User::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :guest_check, except: [:show]
  
  def myshow
    @user = current_user
    @contents = @user.contents.page(params[:page])
    @favorite_contents = @user.favorites.order(created_at: :desc)  
    @comment_contents = @user.comments.order(created_at: :desc)  
  end

  def show
    @user = User.find(params[:id])
    @contents = @user.contents.page(params[:page])
    @favorite_contents = @user.favorites.order(created_at: :desc)  
    @comment_contents = @user.comments.order(created_at: :desc)  
  end

  def edit
    @user = current_user
  end
  
  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to myshow_path, notice: 'ユーザ情報の更新が完了しました。'
    else
      flash[:alert] = "更新が失敗しました"
      redirect_to edit_information_path
    end
  end

  def finalcheck
  end
  
  def withdraw
    @user.update(is_deleted: true)
    reset_session
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :profile_image, :myspot )
  end
  
  def guest_check
    if current_user.email == 'guest@example.com'
      redirect_to contents_path, alert: "マイページの確認はユーザ登録が必要です。"
    end
  end
  
end
