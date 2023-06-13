class User::UsersController < ApplicationController
  def show
  end

  def edit
    @user = current_user
  end
  
  def update
    if @user.update(customer_params)
      redirect_to mypage_path, notice: '会員情報の更新が完了しました。'
    else
      render :edit
    end
  end

  def finalcheck
  end
  
  def withdraw
    @user = current_user
    @user.update(is_deleted: true)
    reset_session
    redirect_to root_path
  end

end
