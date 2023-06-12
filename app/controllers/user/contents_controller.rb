class User::ContentsController < ApplicationController
  def index
    @contents = Content.all
    @user = current_user
  end

  def show
    @content = Content.find(params[:id])
  end

  def new
    @user = current_user
    @content = Content.new
  end
  
  def create
    @content = Content.new(content_params)
    @content.user = current_user
    if @content.save
      flash[:notice] = "投稿しました"
      redirect_to contents_path
    else
      render :new
    end
  end

  def edit
  end
  
  private
  
  def content_params
    params.require(:content).permit(:visit_day,:title, :spot, :text, :review, tag_ids: [])
  end
  
end
