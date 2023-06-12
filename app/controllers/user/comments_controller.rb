class User::CommentsController < ApplicationController
  
  
  def create
    content = Content.find(params[:content_id]) 
    comment = content.comments.new(comment_params)
    comment.user = current_user
    if comment.save
      redirect_to content_path(content), notice: 'コメントを投稿しました。'
    else
      flash.now[:alert] = 'コメントの投稿に失敗しました。'
      render 'contents/index'
    end
  end
  
  def destroy
    comment = Comment.find(params[:id])
    book = comment.book
    comment.destroy
    redirect_to book_path(book), notice: 'コメントを削除しました。'
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end
end
