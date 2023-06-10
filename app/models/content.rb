class Content < ApplicationRecord
    belongs_to :user, optional: true
    has_many :comments, dependent: :destroy
    has_many :tags, dependent: :destroy
end
