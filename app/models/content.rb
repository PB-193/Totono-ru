class Content < ApplicationRecord
    belongs_to :user
    has_many :comments, dependent: :destroy
    has_many :content_tags, dependent: :destroy
    has_many :tags, through: :content_tags
    
    # accepts_nested_attributes_for :content_tags, allow_destroy: true
    # accepts_nested_attributes_for :tags
end
