class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post
  before_action :set_comment, only: %i[edit update destroy]
  # def index
  #   @post = Post.find(params[:post_id])
  #   @comments = @post.comments
  #   @comment = @post.comments.new
  # end

  def create
    @post = Post.find(params[:post_id])  # Find the specific post
    @comment = @post.comments.new(comment_params)  # Build the comment
    @comment.user = current_user  # Associate the comment with the current user

    if @comment.save
      redirect_to post_comments_path(@post)  # Redirect to the comments page for that post
    else
      render :new  # If the comment fails to save, re-render the form
    end
  end

  def edit
    # This action will render the edit form for the comment
  end

  def update
    if @comment.user == current_user
      if @comment.update(comment_params)
        redirect_to post_path(@post), notice: 'Comment was successfully updated.'
      else
        render :edit
      end
    else
      redirect_to post_path(@post), alert: 'You are not authorized to update this comment.'
    end
  end

  def destroy
    if @comment.user == current_user
      @comment.destroy
      redirect_to post_path(@post), notice: 'Comment was successfully deleted.'
    else
      redirect_to post_path(@post), alert: 'You are not authorized to delete this comment.'
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_comment
    @comment = @post.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
