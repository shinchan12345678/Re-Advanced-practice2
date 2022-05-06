class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit,:update]

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
    # unless current_user==@user
      current_user_relations=RoomRelation.where(user_id: current_user.id)
      # binding.pry
      current_user_relations.each do |user_relation|
        if RoomRelation.where(room_id: user_relation.room_id).pluck(:user_id).include?(@user.id)
          @roomId=user_relation.room_id
        end
      end
    # end
  end

  def index
    @users = User.all
    @book = Book.new
  end

  def edit
    @user=User.find(params[:id])
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "You have updated user successfully."
    else
      @books=Book.all
      render "edit"
    end
  end

  def followers
    # binding.pry
    user=User.find(params[:id])
    @users=user.followers
  end

  def following
    # binding.pry
    user=User.find(params[:id])
    @users=user.following
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
end
