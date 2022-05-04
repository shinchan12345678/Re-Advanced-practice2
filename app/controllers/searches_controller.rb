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
end
