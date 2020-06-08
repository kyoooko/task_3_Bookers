class UsersController < ApplicationController
  # deviseのメソッドで、ログインしてなかったらログイン画面に返す
  before_action :authenticate_user!
  
  before_action :ensure_correct_user, {only: [:edit, :update]}
  def ensure_correct_user
    if current_user.id !=  params[:id].to_i
     redirect_to user_path(current_user.id)
    end
  end

  
  def show
    @user = User.find(params[:id])
    @book=Book.new
    @books=@user.books
    # binding.pry
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
      flash[:user_update]= ""
      redirect_to user_path(@user.id)
     else
      render :edit
    end
  end


  # フォロー機能
  def follows
    @user = User.find(params[:id])
  end
  def followers
    @user = User.find(params[:id])
  end


  private 
  def user_params
      params.require(:user).permit(:name, :profile_image,:introduction,:postal_code, :prefecture_code, :city, :street)
  end
end
