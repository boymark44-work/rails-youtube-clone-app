class Admin::UsersController < Admin::BaseController
  def index
    #@users = User.includes(:posts).all 

    # .page(params[:page]) => grabs the page number from the URL
    # .per(10) => displays 10 user per page
    @users = User.order(:created_at).page(params[:page]).per(10)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_users_path, notice: "User updated successfully."
    else
      render :edit   
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path, notice: "User deleted."
  end

  private   

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email)
  end
end
