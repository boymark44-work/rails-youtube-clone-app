class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # User Posts/Videos
  has_many :posts

  # User Likes
  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post

  # User Notifications
  has_many :notifications, as: :recipient, dependent: :destroy

  # Adding the Admin and Regular User Associations
  has_many :sent_notes, class_name: 'Note', foreign_key: 'sender_id', dependent: :destroy
  has_many :received_notes, as: :recipient, class_name: 'Note', dependent: :destroy    
end