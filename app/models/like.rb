class Like < ApplicationRecord
  belongs_to :user
  
  # Notifications
  belongs_to :likeable, polymorphic: true
  validates :user_id, uniqueness: { scope: [:likeable_type, :likeable_id] } # Validation to prevent multiple likes from same user per likeable
  after_create :create_notification 
  
  def create_notification
    return if user == likeable.user # Don't notify yourself    

    # Explanation: We are using likeable.user instead of post.user, since  likeable can be a Post or a Comment,
    # both must belong_to :user
    Notification.create!(
      user: likeable.user, 
      notifiable: self, 
      message: "#{user.email} liked your #{likeable_type.downcase}", 
      read: false
    )
  end
end
