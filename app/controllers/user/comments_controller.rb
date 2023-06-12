class User::CommentsController < ApplicationController
  
  
  def create
    content = Content.find(params[:content_id]) 
    comment = content.comments.new(comment_params)
    comment.user = current_user
    if comment.save
      redirect_to content_path(content), notice: 'コメントを投稿しました。'
    else
      redirect_to content_path(content), notice: 'コメントに失敗しました。'
    end
  end

  def destroy
    content = Content.find(params[:content_id])
    comment = Comment.find(params[:id])
    content = comment.content
    comment.destroy
    redirect_to content_path(content), notice: 'コメントを削除しました。'
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end
  
end
