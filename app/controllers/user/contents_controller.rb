class User::ContentsController < ApplicationController
  def index
    @contents = Content.page(params[:content]).per(10)
    @tag_list=Tag.all
    @user = current_user
  end

  def show
    @content = Content.find(params[:id])
    @comment = Comment.new
  end

  def new
    @user = current_user
    @content = Content.new
  end
  
  def create
    @content = Content.new(content_params)
    @content.user = current_user
    # tag作成で受け取った値を,で区切って配列にする
    tag_list=params[:content][:name].split(',')
    if @content.save
      @content.save_tag(tag_list)
      flash[:notice] = "投稿しました"
      redirect_to contents_path
    else
      render :new
    end
  end

  def edit
    @user = current_user
    @content = Content.find(params[:id])
  end
  
  def update
    @content = Content.find(params[:id])
    if @content.update(content_params)
      flash[:notice] ="更新が完了しました"
      redirect_to content_path
    else
      render :edit
    end
  end
  
  def destroy
    @content = Content.find(params[:id])
    @content.destroy
    flash[:notice] = "削除しました"
    redirect_to contents_path
  end
  
  private
  
  def content_params
    params.require(:content).permit(:visit_day,:title, :spot, :text, :review)
  end
  
end
