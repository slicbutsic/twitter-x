class LikesController < ApplicationController
  before_action :authenticate_user!
  def create
    @post = Post.find(params[:post_id])
    @like = @post.likes.create(user_id: current_user.id)
    if @like.save
    # let the user on the same page, when they like a post
      redirect_to request.referer || root_path, notice: 'You liked the post'
    else
      redirect_to root_path, alert: 'Unable to like the post'
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @like = @post.likes.find(params[:id])

    if @like.destroy
    # let the user on the same page, when they unlike a post
      redirect_to request.referer || root_path, notice: 'You liked the post'
    else
      redirect_to post_path(@post), alert: 'Unable to remove like.'
    end
  end
end
