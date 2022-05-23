class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    # binding.pry
    @book = Book.find(params[:book_id])
    favorite = current_user.favorites.new(book_id: @book.id)
    if favorite.save
      # redirect_to request.referer
      @book = Book.find(params[:book_id])
    end
  end

  def destroy
    # binding.pry
    @book = Book.find(params[:book_id])
    favorite = Favorite.find_by(user_id: current_user.id, book_id: @book.id)
    if favorite.destroy
      # redirect_to request.referer
      @book = Book.find(params[:book_id])
    end
  end
end
