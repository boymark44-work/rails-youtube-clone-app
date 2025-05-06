class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def edit
    @user = current_user
  end

  def update
    @user = current_user

    if updating_sensitive_info? && !@user.valid_password?(params[:user][:current_password])
      @user.errors.add(:current_password, "is incorrect")
      return render :edit, status: :unprocessable_entity      
    end

    # Do not include current_password in the update
    user_attributes = user_params.except(:current_password)

    if @user.update(user_attributes)
      bypass_sign_in(@user) # So Devise doesn't log the user out after password or email change
      redirect_to edit_profile_path, notice: "Profile updated successfully."
    else
      Rails.logger.debug "Updated failed: #{@user.errors.full_messages}"
      render :edit, status: :unprocessable_entity
    end
  end

  private 

  def user_params
    permitted = [:first_name, :last_name, :email]
    permitted += [:password, :password_confirmation] if password_being_changed?
    permitted << :current_password # This is for validation, not for saving
    params.require(:user).permit(permitted)
  end

  def password_being_changed?
    params[:user][:password].present?
  end

  def updating_sensitive_info?
    params[:user][:email] != current_user.email || password_being_changed?
  end
end
