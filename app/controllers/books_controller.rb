class BooksController < ApplicationController

  before_action :authenticate_user!

  def index
    @user = User.find_by(id: current_user.id)
    @book=Book.new
    @books=Book.all
  end

  def create
  @book=Book.new(book_params)
  @book.user_id = current_user.id
    if @book.save
      flash[:create]= ""
      redirect_to  book_path(@book.id)
    else
      @user = User.find_by(id: current_user.id)
      @book=Book.new
      @books=Book.all
      flash.now[:alert_create]=  ""
      render :index
    end
  end


  def show
    @book=Book.find(params[:id])
    @user =@book.user

    @create_book=Book.new
  end

  def edit
    @book=Book.find(params[:id])    
  end

  def update
    @book=Book.find(params[:id])
    @book.update(book_params)
    redirect_to book_path(@book.id)
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end


  private

  def book_params
    params.require(:book).permit(:title, :opinion, :user)
  end

end
