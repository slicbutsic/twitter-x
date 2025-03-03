class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @like = @post.likes.create(user_id: current_user.id)
    if @like.save
      redirect_to @post, notice: 'You liked the post'
    else
      redirect_to root_path, alert: 'Unable to like the post'
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @like = @post.likes.find(params[:id])

    if @like.destroy
      redirect_to post_path(@post), notice: 'Like removed successfully.'
    else
      redirect_to post_path(@post), alert: 'Unable to remove like.'
    end
  end
end
