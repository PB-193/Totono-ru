class Tag < ApplicationRecord
    belongs_to :user
    belongs_to :tag
    
    validates :name,presence:true
end
