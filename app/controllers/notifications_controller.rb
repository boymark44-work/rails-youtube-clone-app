class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @notifications = current_user.notifications.order(created_at: :desc)
  end

  def update
    notification = current_user.notifications.find(params[:id])
    notification.update(read: true)
    redirect_to notification_path(notification.notifiable)
  end

  def mark_all_read
    current_user.notifications.update_all(read: true)
    redirect_to notifications_path, notice: "All notifications marked as read."
  end

end
