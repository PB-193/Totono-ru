class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  before_action :ensure_user, only: [:show, :update]

  def index
    @users = User.all
  end

  def show
  end
  
  def update
    if @user.update(user_params)
      redirect_to admin_user_path(@user), notice: "更新しました"
    else
      flash[:alert] = "更新に失敗しました"
      render :show
    end
  end
  
  private

  def user_params
    params.require(:user).permit(:is_deleted)
  end

  def ensure_user
    @user = User.find(params[:id])
  end
end
