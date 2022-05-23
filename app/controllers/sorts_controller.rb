class SortsController < ApplicationController
  def sort
    # binding.pry
    rule = params[:rule]
    if rule == "new"
      @books = Book.all.sort do |a, b|
        b.created_at <=>
        a.created_at
      end
    else
      @books = Book.all.sort do |a, b|
        b.rate <=>
        a.rate
      end
    end
    # binding.pry
  end
end
