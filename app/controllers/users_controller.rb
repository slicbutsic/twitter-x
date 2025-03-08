class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]

  def show
    # @user is already set by before_action
    @posts = @user.posts
    @likes = Like.all
    @followers = Follow.all
    @followings = Follow.all
  end

  def edit
    # before_action
  end

  def update
    # before_action
    if @user.update(user_params)
      redirect_to @user, notice: 'Profile updated successfully.'
    else
      render :edit
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:bio)
  end
end
