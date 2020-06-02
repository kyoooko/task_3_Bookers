class BooksController < ApplicationController

  before_action :authenticate_user!

  before_action :ensure_correct_user, {only: [:edit, :update]}
  def ensure_correct_user
    @book=Book.find(params[:id])
    if current_user.id !=  @book.user_id
     redirect_to books_path
    end
  end
  

  def index
    @user = User.find_by(id: current_user.id)
    @book=Book.new
    @books=Book.all
  end

  def create
  @book=Book.new(book_params)
  binding.pry
  @book.user_id = current_user.id
    if @book.save
      flash[:create]= ""
      redirect_to  book_path(@book.id)
    else
      @user = User.find_by(id: current_user.id)
      @books=Book.all
      flash.now[:alert_create]=  ""
      render :index
    end
  end


  def show
    @book=Book.find(params[:id])
    @create_book=Book.new
    @book_comment = BookComment.new
  end

  def edit
    @book=Book.find(params[:id])    
  end

  def update
    @book=Book.find(params[:id])
    if @book.update(book_params)
      flash[:book_update]= ""
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end


  private

  def book_params
    params.require(:book).permit(:title, :body, :user)
  end

end
