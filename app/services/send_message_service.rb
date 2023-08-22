class SendMessageService
  def initialize(content)
    @content = content
  end
  
  def send_message_to_favorited_users
    favorited_users = Favorite.where(content_id: @content.user.contents.pluck(:id)).pluck(:user_id).uniq
    favorited_users.each do |user_id|
      user = User.find(user_id)
      # 投稿した本人にメールを送信しない
      unless user_id == @content.user.id
        FavoritedUserMailer.new_content_message_email(user, @content).deliver_now
      end
    end
  end
end
