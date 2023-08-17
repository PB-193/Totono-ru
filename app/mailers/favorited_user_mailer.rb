
class FavoritedUserMailer < ApplicationMailer
  def new_content_message_email(user, content)
    @user = user
    @content = content
    mail(to: @user.email, subject: '【ととの〜る】いいねしたユーザが新しいレビューを投稿しました!')
  end
end