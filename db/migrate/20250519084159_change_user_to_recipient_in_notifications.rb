class ChangeUserToRecipientInNotifications < ActiveRecord::Migration[7.1]
  def change
    remove_reference :notifications, :user, foreign_key: true 
    add_reference :notifications, :recipient, polymorphic: true, null: false
  end
end
