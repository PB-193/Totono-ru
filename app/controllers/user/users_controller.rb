class User::UsersController < ApplicationController
  before_action :authenticate_user_or_admin!
  before_action :guest_check, except: [:show]
  
  def myshow
    @user = current_user
    @contents = @user.contents.order(created_at: :asc).page(params[:page])
    @favorite_contents = @user.favorites.order(created_at: :asc).page(params[:page])
    @comment_contents = @user.comments.order(created_at: :asc).page(params[:page])
  end


  def show
    @user = User.find(params[:id])
    @contents = @user.contents.page(params[:page]).order(created_at: :asc)
    @favorite_contents = @user.favorites.order(created_at: :asc).page(params[:page])
    @comment_contents = @user.comments.order(created_at: :asc).page(params[:page])
  end

  def edit
    @user = current_user
  end
  
  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to myshow_path, notice: 'ユーザ情報の更新が完了しました。'
    else
      flash[:alert] = "更新が失敗しました。ユーザ名とメールアドレスの入力は必須です。"
      redirect_to edit_information_path
    end
  end

  def finalcheck
  end
  
  def withdraw
    @user = current_user
    @user.update(is_deleted: true)
    reset_session
    redirect_to root_path, notice: 'アカウントが停止しました。ご利用頂きありがとうございました。再度、同じアカウントでご利用したい場合はお問い合わせフォームからお問い合わせください。'
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
  
  def authenticate_user_or_admin!
    authenticate_user! unless admin_signed_in?
  end
  
end
