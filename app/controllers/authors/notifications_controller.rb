class Authors::NotificationsController < ApplicationController
  before_action :authenticate_author!

  def index 
    @notifications = current_author.notifications.order(created_at: :desc)
  end

  def update 
    notification = current_author.notifications.find(params[:id])
    notification.update(read: true)
    
    redirect_to authors_notes_path
  end

  def mark_all_as_read
    current_author.notifications.update_all(read: true)

    redirect_to authors_notifications_path, notice: "All notifications marked as read"
  end
end