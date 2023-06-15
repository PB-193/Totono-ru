class User::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_current_user

  def show
  end

  def edit
  end
  
  def update
    if @user.update(user_params)
      redirect_to mypage_path, notice: 'ユーザ情報の更新が完了しました。'
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
  
  def set_current_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:name, :email, :profile_image )
  end

end
