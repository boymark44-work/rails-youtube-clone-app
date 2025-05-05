class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def edit
    @user = current_user
  end

  def update
    @user = current_user

    if @user.update(user_params)
      redirect_to edit_profile_path, notice: 'Profile Updated Successfully'   
    else 
      render :edit, alert: 'Failed To Update Profile'
    end
  end

  private 

  def user_params
    params.require(:user).permit(:first_name, :last_name)
  end

end
