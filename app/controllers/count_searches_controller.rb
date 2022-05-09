class CountSearchesController < ApplicationController
  def search
    user=User.find(params[:user_id])
    year=params[:created_at].slice(0,4).to_i
    month = params[:created_at].slice(5,2).to_i
    day = params[:created_at].slice(8,2).to_i
    # binding.pry
    date=Date.new(year,month,day)
    to=date.at_end_of_day
    from=(date.at_end_of_day).at_beginning_of_day
    @day_posts=user.books.where(created_at: from..to).count
    # binding.pry
    
  end
end
