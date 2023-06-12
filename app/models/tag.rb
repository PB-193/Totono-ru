class Tag < ApplicationRecord
    has_many :content_tags, dependent: :destroy, foreign_key: 'tag_id'
    has_many :contents, through: :content_tags
    
    validates :name,presence:true
end
