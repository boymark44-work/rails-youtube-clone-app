class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @notifications = current_user.notifications.order(created_at: :desc)
  end

  def update
    notification = current_user.notifications.find(params[:id])
    notification.update(read: true)
    
    case notification.notifiable
    when Note 
      return redirect_to notes_path 
    when Like 
      return redirect_to post_path(notification.notifiable.likeable)  
    else 
      return redirect_to root_path 
    end
  end

  def mark_all_read
    current_user.notifications.update_all(read: true)
    redirect_to notifications_path, notice: "All notifications marked as read."
  end

end
