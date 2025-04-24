class LikesController < ApplicationController
  before_action :authenticate_user! # For Devise
  before_action :set_post
  
  def create
    if @post.likes.where(user: current_user).exists?
      @post.likes.find_by(user: current_user).destroy  
    else 
      @post.likes.create(user: current_user)
    end
    redirect_to post_path(@post)
  end

  private   

  def set_post
    @post = Post.find(params[:post_id])
  end

end
