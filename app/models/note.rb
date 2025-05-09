class Note < ApplicationRecord
  belongs_to :sender, class_name: 'User'
  belongs_to :recipient, polymorphic: true

  validates :body, presence: true
end
