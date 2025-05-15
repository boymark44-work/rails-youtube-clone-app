class Authors::BlogsController < ApplicationController
    before_action :authenticate_author!

    def index 
        @blogs = current_author.blogs.order(created_at: :desc)
    end

    def new 
        @blog = current_author.blogs.new 
    end

    def create
        @blog = current_author.blogs.new(blog_params)
        if @blog.save 
            redirect_to authors_blogs_path, notice: "Blog created."
        else 
            render :new 
        end
    end

    private  

    def blog_params
        params.require(:blog).permit(:title, :content)
    end
end
