class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :set_user, only: [:index, :show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :owned_post, only: [:edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.order(created_at: :desc)
    new
    # @like_status = @user.likes?(@post) ? 'Unlike' : 'Like'
    # @like_count = @posts.get_likers_count
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = current_user.posts.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = current_user.posts.new(post_params)

      if @post.save
        flash[:success] = "Post successful!"
        redirect_to root_path
      else
        flash.now[:alert] = "Post failed, please try again."
        redirect_to root_path
      end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def toggle_like
    @post = Post.find(params[:post_id])
    current_user.toggle_like!(@post)
    # params = {post_id: 1}
    redirect_to root_path
  end

  def toggle_follow
    @user = User.find(params[:user_id])
    current_user.toggle_follow!(@user)
    redirect_to root_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    def set_user
      @user = current_user
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:name, :content)
    end

    def owned_post
      unless current_user == @post.user
        flash[:alert] = "This is not your post!"
        redirect_to root_path
      end
    end
end
