class Notification < ApplicationRecord
  belongs_to :recipient, polymorphic: true 
  belongs_to :notifiable, polymorphic: true

  scope :unread, -> { where(read: false) }
  scope :read, -> { where(read: true) }
end
