class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books,dependent: :destroy
  has_many :favorites,dependent: :destroy
  has_many :book_comments,dependent: :destroy
  has_one_attached :profile_image

  has_many :active_relationships,class_name: "Relationship",
                                foreign_key: "follower_id",
                                dependent: :destroy
  has_many :following,through: :active_relationships,source: :followed

  has_many :passive_relationships,class_name:  "Relationship",
                                  foreign_key: "followed_id",
                                  dependent: :destroy
  has_many :followers,through: :passive_relationships,source: :follower

  has_many :room_relations,dependent: :destroy
  has_many :direct_messages,dependent: :destroy
  has_many :book_views,dependent: :destroy
  has_many :group_mambers,dependent: :destroy
  has_one :group ,inverse_of: "owner_user"

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true,presence: true
  validates :introduction, length: { maximum: 50 }

  def follow(other_user)
    active_relationships.create(followed_id: other_user.id)
  end

  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following?(other_user)
    following.include?(other_user)
  end

  def self.search_by(condition,query)
    case condition
    when "部分一致" then
      User.where("name LIKE?","%#{query}%")
    when "前方一致" then
      User.where("name LIKE?","#{query}%")
    when "後方一致" then
      User.where("name LIKE?","%#{query}")
    when "完全一致" then
      User.where("name LIKE?","#{query}")
    end
  end

  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end
end
