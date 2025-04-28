class CommentsController < ApplicationController
    def create
        @post = Post.find(params[:post_id])
        @comment = Comment.new(comment_params)
        @comment.user = current_user

        if @comment.save
            redirect_to @post, notice: "Comment posted!"
        else 
            render 'posts/show', status: :unprocessable_entity
        end
    end

    private  

    def comment_params
        params.require(:comment).permit(:body, :parent_id)
    end
end