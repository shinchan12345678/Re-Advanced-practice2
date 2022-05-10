class Category < ApplicationRecord
  has_many :books
  validates :category_name,uniqueness: true
end
