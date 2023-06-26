class User::ContentsController < ApplicationController
  before_action :authenticate_user!
  before_action :guest_check, only: [:new, :create]

  def index
    @contents = Content.page(params[:page])
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
    tag_list=params[:content][:name].split(',')
    if @content.save
      @content.save_tag(tag_list)
      flash[:notice] = "投稿しました"
      redirect_to contents_path
    else
      flash[:alert] = "タイトルの入力は必須になります"
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
      flash[:notice] ="編集が完了しました"
      redirect_to content_path
    else
      flash[:alert] ="編集が失敗しました"
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
    params.require(:content).permit(:visit_day,:title, :spot, :text, :rate)
  end
  
  def guest_check
    if current_user.email == 'guest@example.com'
      redirect_to contents_path, alert: "投稿をするには会員登録が必要です。"
    end
  end

  
end
