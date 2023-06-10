class User::ContentsController < ApplicationController
  def index
    @contents = Content.all
  end

  def show
  end

  def new
    @content = Content.new
  end
  
  def create
    @content = current_user.contents.build(content_params)
    @content = Content.new(content_params)
    @content.user_id = session[:user_id]
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
    params.require(:content).permit(:visit_day,:title, :spot, :text, :review)
  end
  
end
