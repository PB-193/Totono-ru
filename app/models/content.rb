class Content < ApplicationRecord
    belongs_to :user
    has_many :comments, dependent: :destroy
    has_many :content_tags, dependent: :destroy
    has_many :tags, through: :content_tags
    has_many :favorites, dependent: :destroy
    
    # 画像投稿機能を追加
    has_one_attached :review_image
    
    def get_review_image
      unless review_image.attached?
        file_path = Rails.root.join('app/assets/images/no_image.jpg')
        profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
      end
      review_image
    end
    
    validates :title,presence:true, length: { minimum: 3, maximum: 35 }
    validates :text ,presence:true
    
    # お気に入りの多い順にソートする'スコープ'を定義
    scope :ordered_by_favorite_count, -> {
      left_joins(:favorites)
        .select('contents.*, COUNT(favorites.id) AS favorite_count')
        .group('contents.id')
        .order('favorite_count DESC')
    }
    
    # コメントが多い順にソートする'スコープ'を定義
    scope :ordered_by_comment_count, -> {
      left_joins(:comments)
        .select('contents.*, COUNT(comments.id) AS comment_count')
        .group('contents.id')
        .order('comment_count DESC')
    }

    # 既にいいね済みであれば、複数回いいねはできない処理 
    def favorited_by?(user)
        favorites.where(user_id: user.id).exists?
    end

    def save_tag(sent_tags)
      # タグが存在していれば、タグの名前を配列として全て取得
        current_tags = self.tags.pluck(:name) unless self.tags.nil?
        # 現在取得したタグから送られてきたタグを除いてoldtagとする
        old_tags = current_tags - sent_tags
        # 送信されてきたタグから現在存在するタグを除いたタグをnewとする
        new_tags = sent_tags - current_tags
    
        # 古いタグを消す
        old_tags.each do |old|
          tag = Tag.find_by(name:old)
          self.tags.delete(tag)
          unless ContentTag.find_by(id: tag.id)
            tag.destroy
          end
        end
    
        # 新しいタグを保存
        new_tags.each do |new|
          content_tag = Tag.find_or_create_by(name:new)
          self.tags << content_tag
       end
    end
    
        
    # 新しいレビューがデータベースに保存された後に以下のメソッドが実行する。（コールバック）
    after_create :send_message_to_favorited_users
    
    private
    
    # いいねしたユーザのIDリストを取得するメソッド
    def send_message_to_favorited_users
      favorited_users = Favorite.where(content_id: self.user.contents.pluck(:id)).pluck(:user_id).uniq
      favorited_users.each do |user_id|
        user = User.find(user_id)
        # 投稿した本人にメールを送信しない
        unless user_id == self.user.id
          FavoritedUserMailer.new_content_message_email(user, self).deliver_now
        end
      end
    end

end
