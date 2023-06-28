class User::CommentsController < ApplicationController
  
  # 非同期通信で行う
  def create
    @content = Content.find(params[:content_id])
    comment = @content.comments.build(comment_params)
    comment.user = current_user
    respond_to do |format|
      if comment.save
        format.html { redirect_to content_path(@content), notice: 'コメントを作成しました。' }
        format.js # create.js.erbが実行される
      else
        format.html { redirect_to content_path(@content), alert: 'コメントに失敗しました。' }
        format.js 
      end
    end
  end

  # 非同期通信で行う
  def destroy
    comment = Comment.find_by(id: params[:id], content_id: params[:content_id])
    @content = Content.find(params[:content_id])
    comment.destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end
  
end
