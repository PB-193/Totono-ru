class Admin::ContentsController < ApplicationController
  before_action :authenticate_admin!

  def show
    @content = Content.find(params[:id])
  end

  def update
    @content = Content.find(params[:id])
    
    if @content.update(content_params)
      flash[:notice] = "投稿日を更新しました"
          redirect_to admin_homes_top_path
    else
      flash[:alert] = "更新に失敗しました"
    redirect_to admin_homes_top_path
    end
  end

  def destroy
    @content = Content.find(params[:id])
    @content.destroy
    flash[:notice] = "削除しました"
    redirect_to admin_homes_top_path
  end

  private

  def content_params
    params.permit(:created_at)
  end
end

