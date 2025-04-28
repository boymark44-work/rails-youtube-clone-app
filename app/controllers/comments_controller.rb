class CommentsController < ApplicationController
    before_action :set_post

    def create
        @comment = @post.comments.new(comment_params)
        @comment.user = current_user # Assuming we have Devise setup already

        if @comment.save
            redirect_to @post, notice: "Comment posted successfully!"
        else 
            redirect_to @post, alert: "Failed to post comment."
        end
    end

    private  

    def set_post
        @post = Post.find(params[:post_id])
    end

    def comment_params
        params.require(:comment).permit(:body, :parent_id)
    end
end