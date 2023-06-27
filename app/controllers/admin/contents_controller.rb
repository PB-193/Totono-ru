class Admin::ContentsController < ApplicationController
  
  def show
    @content = Content.find(params[:id])
  end

  def destroy
    @content = Content.find(params[:id])
    @content.destroy
    flash[:notice] = "削除しました"
    redirect_to admin_homes_top_path
  end

end
