class SortsController < ApplicationController
  def sort
    # binding.pry
    rule=params[:rule]
    if rule=="new"
      @books=Book.all.sort {|a,b|
        b.created_at<=>
        a.created_at
      }
    else
      @books=Book.all.sort {|a,b|
        b.rate<=>
        a.rate
      }
    end
    # binding.pry
  end
end

