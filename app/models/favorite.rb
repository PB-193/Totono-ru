class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :content, counter_cache: true
end
