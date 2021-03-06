class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def show
    @book = Book.find(params[:id])
    book_view = BookView.find_by(book_id: @book.id, user_id: current_user.id)
    if book_view
      sum = book_view.counter + 1
      book_view.update(book_id: @book.id, user_id: current_user.id, counter: sum)
    else
      BookView.create(book_id: @book.id, user_id: current_user.id, counter: 1)
    end
    @book_view = BookView.find_by(book_id: @book.id, user_id: current_user.id)
  end

  def index
    # @books = Book.order_all_between
    # binding.pry
    to = Time.current.at_end_of_day
    from = (to - 6.day).at_beginning_of_day
    @books = Book.all.sort do |a, b|
      b.favorites.where(created_at: from...to).size <=>
      a.favorites.where(created_at: from...to).size
    end
    @book = Book.new
  end

  def create
    # binding.pry
    @book = Book.new(book_params)
    if Category.find_by(category_name: params.require(:book)[:category_name])
      category = Category.find_by(category_name: params.require(:book)[:category_name])
    else
      category = Category.create(category_params)
    end
    # binding.pry
    @book.user_id = current_user.id
    @book.category_id = category.id
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
    # binding.pry
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    # binding.pry
    if @book.update(book_update_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body, :rate)
  end

  def book_update_params
    params.require(:book).permit(:title, :body)
  end

  def category_params
    params.require(:book).permit(:category)
  end

  def ensure_correct_user
    @book = Book.find(params[:id])
    unless @book.user == current_user
      redirect_to books_path
    end
  end
end
