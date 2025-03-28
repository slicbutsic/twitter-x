class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: %i[show edit update destroy]
  def index
    # @posts = Post.all
    @posts = Post.from_followed_users(current_user).order(created_at: :desc).page(params[:page]).per(15)
  end

  def show
    # @post = Post.find(params[:id])
    @comments = @post.comments.all
    @comment = @post.comments.new
    @likes = Like.all

    @user = @post.user
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    respond_to do |format|
      if @post.save
        format.turbo_stream
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end


  def edit
    # @post = Post.find(params[:id])
  end

  def update
    if @post.update(post_params)
      redirect_to root_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    redirect_to request.referer || posts_path, notice: 'You liked the post'
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:tweet)
  end
end
