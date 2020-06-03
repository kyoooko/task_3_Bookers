class BookCommentsController < ApplicationController
  def create
    @book = Book.find(params[:book_id])
    @comment = BookComment.new(book_comment_params)
    @comment.user_id = current_user.id
    @comment.book_id = @book.id
    if @comment.save
      # 非同期通信のため変更
    # redirect_to book_path(@book)
    render :index
    else
      # @create_book=Book.new
      # @book_comment = BookComment.new
      # 非同期通信のため変更
      # redirect_to book_path(@book)
      render :index
    end
  end
  
  def destroy
    @book = Book.find(params[:book_id])
    @comment=BookComment.find_by(id: params[:id], book_id: params[:book_id])
    # 非同期通信のため変更
    # redirect_to book_path(params[:book_id])
    if @comment.destroy
      # binding.pry
      render :index 
    end
  end

  private
  def book_comment_params
      params.require(:book_comment).permit(:comment)
  end
end
