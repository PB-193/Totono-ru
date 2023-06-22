class Content < ApplicationRecord
    belongs_to :user
    has_many :comments, dependent: :destroy
    has_many :content_tags, dependent: :destroy
    has_many :tags, through: :content_tags
    
    validates :title,presence:true

    def save_tag(sent_tags)
      # タグが存在していれば、タグの名前を配列として全て取得
        current_tags = self.tags.pluck(:name) unless self.tags.nil?
        # 現在取得したタグから送られてきたタグを除いてoldtagとする
        old_tags = current_tags - sent_tags
        # 送信されてきたタグから現在存在するタグを除いたタグをnewとする
        new_tags = sent_tags - current_tags
    
        # 古いタグを消す
        old_tags.each do |old|
          self.tags.delete　Tag.find_by(name: old)
        end
    
        # 新しいタグを保存
        new_tags.each do |new|
          new_post_tag = Tag.find_or_create_by(name: new)
          self.tags << new_post_tag
       end
    end


end
