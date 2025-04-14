class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]

  # GET /posts or /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1 or /posts/1.json
  # To prevent unnecessary database queries, preload attachments in the show action: 
  def show
    @post = Post.includes(video_attachment: :blob, image_attachment: :blob).find(params[:id])
  end

  
  # GET /posts/new
  def new
    @post = Post.new
  end

  # Download video
  def download
    # Fetch the post by its ID
    @post = Post.find(params[:id])

    # Ensure a video or image is attached before proceeding
    if @post.video.attached?
      send_data @post.video.download, filename: @post.video.filename.to_s
    elsif @post.image.attached?
      send_data @post.image.download, filename: @post.image.filename.to_s
    else 
      flash[:alert] = "No file is attached for download."
      redirect_to post_path(@post) # Redirect to post page if no attachments
    end

  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy!

    respond_to do |format|
      format.html { redirect_to posts_path, status: :see_other, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :description, :image, :video)
    end
end
