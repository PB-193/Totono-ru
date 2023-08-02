class User::ContentsController < ApplicationController
  before_action :authenticate_user!
  before_action :guest_check, only: [:new, :create]

  def index
    @tag_list = Tag.all
    @user = User.find_by(id: params[:user_id])
  
    # Contentモデルに対してクエリを実行するActiveRecord_Relationを用意
    contents_relation = if params[:sort] == 'newest'
                          Content.order(created_at: :desc)
                        elsif params[:sort] == 'oldest'
                          Content.order(created_at: :asc)
                        elsif params[:sort] == 'rate_desc'
                          Content.order(rate: :desc)
                        elsif params[:sort] == 'rate_asc'
                          Content.order(rate: :asc)
                        elsif params[:sort] == 'favorite_desc'
                          Content.ordered_by_favorite_count
                        elsif params[:sort] == 'comment_desc'
                          Content.ordered_by_comment_count
                        elsif params[:sort] == 'random_list'
                          Content.order('RANDOM()')
                        else
                          Content.order(created_at: :asc)
                        end
  
    # ページネーションを適用してデータを取得
    @contents = contents_relation.page(params[:page])
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
  tag_list = params[:content][:tag_name].split(',')

  if @content.save
    @content.save_tag(tag_list)
    flash[:notice] = "投稿しました"
    redirect_to contents_path(sort: 'newest')
  else
    render :new
  end
end


  def edit
    @user = current_user
    @content = Content.find(params[:id])
    @tag_list = @content.tags.pluck(:name).join(',')
  end
  
  def update
    @content = Content.find(params[:id])
    tag_list = params[:content][:tag_name].split(',')
    if @content.update(content_params)
      @content.save_tag(tag_list)
      flash[:notice] ="編集が完了しました"
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
    params.require(:content).permit(:visit_day,:title, :spot, :text, :rate)
  end
  
  def guest_check
    if current_user.email == 'guest@example.com'
      redirect_to contents_path, alert: "投稿をするにはユーザ登録が必要です。"
    end
  end

  
end
