class Comment < ApplicationRecord
    belongs_to :user
    belongs_to :content, counter_cache: true
    
    validates :comment,presence:true

    # コメント日時の表示
    def how_long_ago
      if (Time.now - self.created_at) <= 60 * 60
        # 60分以内なら
        ((Time.now - self.created_at) / 60).to_i.to_s + "分前"
      elsif (Time.now - self.created_at) <= 60 * 60 * 24
        # 24時間以内なら
        ((Time.now - self.created_at) / 3600).to_i.to_s + "時間前"
      elsif (Date.today - self.created_at.to_date) <= 30
        # 30日以内なら
        (Date.today - self.created_at.to_date).to_i.to_s + "日前"
      else
        # それ以降
        self.created_at
      end
    end

end
