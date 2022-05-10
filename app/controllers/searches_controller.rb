class SearchesController < ApplicationController
  def search
    # binding.pry
    @model=params[:model]
    @query=params[:query]
    if @model=="User"
      @users=User.search_by(params[:condition],params[:query])
    else
      @books=Book.search_by(params[:condition],params[:query])
    end
  end
  
  def search_category
    category=Category.find_by(category_name: params[:category])
    if category
      @books=Book.where(category_id: category.id)
    else
      redirect_to books_path
    end
  end
  
end
