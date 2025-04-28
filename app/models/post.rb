class Post < ApplicationRecord
    has_one_attached :image
    has_one_attached :video 
    belongs_to :user 

    has_many :likes, dependent: :destroy 
    has_many :liked_users, through: :likes, source: :user

    has_many :comments, dependent: :destroy
end
