class BookCommentsController < ApplicationController
  def create
    # binding.pry
    book=Book.find(params[:book_id])
    book_comment=current_user.book_comments.new(book_comment_params)
    book_comment.book_id=book.id
    # binding.pry
    if book_comment.save
      # redirect_to request.referer
      @book=Book.find(params[:book_id])
    end
  end

  def destroy
    # binding.pry
    @book_comment=BookComment.find(params[:id])
    # binding.pry
    if @book_comment.destroy
      # redirect_to request.referer
      @book=Book.find(params[:book_id])
    end
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:body)
  end

end
