class Author < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :blogs, dependent: :destroy 
  has_many :received_notes, as: :recipient, class_name: 'Note' 
  has_many :notifications, as: :recipient, dependent: :destroy 
end
