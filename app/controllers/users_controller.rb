class UsersController < ApplicationController
  def show
    @user = User.find_by(id: current_user.id)
    @book=Book.new
    @books=@user.books
  end

  def index
    @users = User.all
    @user = User.find_by(id: current_user.id)
    @book=Book.new
  end

  def edit
    @user = User.find_by(id: current_user.id)
  end

  def update
    @user = User.find_by(id: current_user.id)
    @user.update(user_params)
    redirect_to user_path(@user.id)
  end


  private 
  def user_params
      params.require(:user).permit(:name, :profile_image,:introduction)
  end
end
