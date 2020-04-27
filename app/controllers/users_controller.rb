class UsersController < ApplicationController

  before_action :authenticate_user!
  
  def show
    @user = User.find(params[:id])
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
     if @user.update(user_params)
      flash[:update]= ""
      redirect_to user_path(@user.id)
     else
      render :edit
    end
  end

  private 
  def user_params
      params.require(:user).permit(:name, :profile_image,:introduction)
  end
end
