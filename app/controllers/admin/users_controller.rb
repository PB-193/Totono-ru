class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  before_action :ensure_user, only: [:show, :update]

  def index
    @users = User.all
  end

  def show
  end

  def update
    @user.update(user_params) ? (redirect_to admin_users_path(@user)) : (render :index)
  end
  
  private

  def user_params
    params.require(:user).permit(:is_deleted)
  end

  def ensure_user
    @user = User.find(params[:id])
  end
end
