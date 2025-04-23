class PagesController < ApplicationController
  def media
    if user_signed_in?
      @posts = current_user.posts 

      if @posts.empty?
        @message = "Upload a Video?"
      else
        @message = "Your Videos: "
      end

    end
  end
end
