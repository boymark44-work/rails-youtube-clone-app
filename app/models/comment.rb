class Comment < ApplicationRecord
  belongs_to :user  
  belongs_to :post

  has_ancestry
  validates :body, presence: true
end