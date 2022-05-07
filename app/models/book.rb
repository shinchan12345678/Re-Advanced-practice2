class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites,dependent: :destroy
  has_many :book_comments,dependent: :destroy
  has_many :book_views,dependent: :destroy
  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}

  def favorite_exist?(user)
    favorites.find_by(user_id: user.id)
  end


  def self.search_by(condition,query)
    case condition
    when "部分一致" then
      Book.where("title LIKE?","%#{query}%")
    when "前方一致" then
      Book.where("title LIKE?","#{query}%")
    when "後方一致" then
      Book.where("title LIKE?","%#{query}")
    when "完全一致" then
      Book.where("title LIKE?","#{query}")
    end
  end

  # def self.order_all
  #   Book.find(Favorite.group(:book_id).order("count(book_id) desc").pluck(:book_id))
  # end

  #   def self.order_all_between
  #   Book.find(Favorite.where(created_at: ((Time.current.at_end_of_day - 6.day).at_beginning_of_day)..(Time.current.at_end_of_day)).group(:book_id).order("count(book_id) desc").pluck(:book_id))
  #   end

  

end
