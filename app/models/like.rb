class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post

  # Validation to prevent multiple likes from same user
  validates :user_id, uniqueness: { scope: :post_id }
end
