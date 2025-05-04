class LikesController < ApplicationController
  before_action :authenticate_user! # For Devise
  before_action :set_post
  
  def create
    @like = @post.likes.create(user: current_user, likeable: @post) # To make the association to likeable polymorphic object clear
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to @post }
    end
  end

  def destroy
    @like = @post.likes.find_by(user: current_user, likeable: @post)
    @like.destroy if @like
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to @post }
      end
  end

  private   

  def set_post
    @post = Post.find(params[:post_id])
  end
end
