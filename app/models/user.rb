class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :contents, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :tags, dependent: :destroy
  
  validates :name,presence:true
  validates :email,presence:true
  
end
