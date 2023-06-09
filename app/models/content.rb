class Content < ApplicationRecord
    belongs_to :user
    has_many :comments, dependent: :destroy
    has_many :content_tags, dependent: :destroy
    has_many :tags, through: :content_tags
    has_many :favorites, dependent: :destroy
    
    validates :title,presence:true

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


end
