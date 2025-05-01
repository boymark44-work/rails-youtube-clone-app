class Post < ApplicationRecord
    belongs_to :user 
    
    has_one_attached :image
    has_one_attached :video 

    has_many :likes, dependent: :destroy 
    has_many :liked_users, through: :likes, source: :user

    has_many :comments, dependent: :destroy
end
