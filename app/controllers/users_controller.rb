class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update]
  before_action :ensure_guest_user, only: [:edit]

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
    # unless current_user==@user
    current_user_relations = RoomRelation.where(user_id: current_user.id)
    # binding.pry
    current_user_relations.each do |user_relation|
      if RoomRelation.where(room_id: user_relation.room_id).pluck(:user_id).include?(@user.id)
        @roomId = user_relation.room_id
      end
    end
    # end
    @weekly_posts = []
    weeks = ["6日前", "5日前", "4日前", "3日前", "2日前", "1日前", "今日"]
    (0..6).each do |i|
      to = Time.current.at_end_of_day - i.day
      from = (Time.current.at_end_of_day - i.day).at_beginning_of_day
      @weekly_posts.unshift([weeks.pop, @user.week_posts.where(created_at: from..to).count])
    end
    # binding.pry
  end

  def index
    @users = User.all
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "You have updated user successfully."
    else
      @books = Book.all
      render "edit"
    end
  end

  def followers
    # binding.pry
    user = User.find(params[:id])
    @users = user.followers
  end

  def following
    # binding.pry
    user = User.find(params[:id])
    @users = user.following
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end

  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.name == "guestuser"
      redirect_to user_path(current_user), notice: "ゲストユーザーはプロフィール編集画面へ遷移できません"
    end
  end
end
