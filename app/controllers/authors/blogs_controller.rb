class Authors::BlogsController < ApplicationController
    before_action :authenticate_author!
    before_action :set_blog, only: [:edit, :update, :destroy]

    def index 
        @blogs = current_author.blogs.order(created_at: :desc)
    end

    def new 
        @blog = current_author.blogs.new 
    end

    def create
        @blog = current_author.blogs.new(blog_params)
        if @blog.save 
            redirect_to authors_blogs_path, notice: "Blog created successfully."
        else 
            render :new 
        end
    end

    def edit
    end

    def update
        if @blog.update(blog_params)
            redirect_to authors_blogs_path, notice: "Blog updated successfully."
        else 
            render :edit     
        end
    end

    def destroy  
        @blog.destroy
        redirect_to authors_blogs_path, notice: "Blog deleted successfully."
    end

    private  

    def set_blog
        @blog = current_author.blogs.find(params[:id])
    end


    def blog_params
        params.require(:blog).permit(:title, :content)
    end
end
