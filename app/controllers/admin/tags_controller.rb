class Admin::TagsController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @tags = Tag.all
  end
  
  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      redirect_to admin_tags_path, notice: "タグが作成されました。"
    else
      redirect_to admin_tags_path, alert: "タグの作成に失敗しました。"
    end
  end
  
  
  def delete
    selected_tag_ids = params[:tag_ids] || []
    Tag.where(id: selected_tag_ids).destroy_all
    redirect_to admin_tags_path, notice: 'タグを削除しました。'
  end
  
  private

  def tag_params
    params.require(:tag).permit(:name)
  end
  
end
