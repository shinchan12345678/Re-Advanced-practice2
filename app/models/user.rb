class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_one_attached :profile_image

  # フォロー機能に関するアソシエーション
  has_many :active_relationships, class_name: "Relationship",
                                  foreign_key: "follower_id",
                                  dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed

  has_many :passive_relationships, class_name: "Relationship",
                                   foreign_key: "followed_id",
                                   dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :follower

  # 投稿数に関するアソシエーション
  has_many :today_posts, -> { where(created_at: (Time.current.at_beginning_of_day)..(Time.current.at_end_of_day)) }, class_name: "Book",
                                                                                                                     foreign_key: "user_id",
                                                                                                                     dependent: :destroy
  has_many :yesterday_posts, -> { where(created_at: ((Time.current.at_end_of_day - 1.day).at_beginning_of_day)..(Time.current.at_end_of_day - 1.day)) }, class_name: "Book",
                                                                                                                                                         foreign_key: "user_id",
                                                                                                                                                         dependent: :destroy
  has_many :week_posts, -> { where(created_at: ((Time.current.at_end_of_day - 6.day).at_beginning_of_day)..(Time.current.at_end_of_day)) }, class_name: "Book",
                                                                                                                                            foreign_key: "user_id",
                                                                                                                                            dependent: :destroy
  has_many :last_week_posts, -> { where(created_at: ((Time.current.at_end_of_day - 13.day).at_beginning_of_day)..(Time.current.at_end_of_day - 7.day)) }, class_name: "Book",
                                                                                                                                                          foreign_key: "user_id",
                                                                                                                                                          dependent: :destroy

  has_many :room_relations, dependent: :destroy
  has_many :direct_messages, dependent: :destroy
  has_many :book_views, dependent: :destroy
  has_many :group_members, dependent: :destroy
  has_one :group, inverse_of: "owner_user"

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true, presence: true
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

  def self.search_by(condition, query)
    case condition
    when "部分一致" then
      User.where("name LIKE?", "%#{query}%")
    when "前方一致" then
      User.where("name LIKE?", "#{query}%")
    when "後方一致" then
      User.where("name LIKE?", "%#{query}")
    when "完全一致" then
      User.where("name LIKE?", "#{query}")
    end
  end

  def post_diff_day
    if yesterday_posts.count == 0
      "-"
    else
      (today_posts.count / yesterday_posts.count) * 100
    end
  end

  def post_diff_week
    if last_week_posts.count == 0
      "-"
    else
      (week_posts.count / last_week_posts.count) * 100
    end
  end

  def get_profile_image
    profile_image.attached? ? profile_image : 'no_image.jpg'
  end

  def self.guest
    find_or_create_by!(name: 'guestuser', email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = 'guestuser'
    end
  end
end
