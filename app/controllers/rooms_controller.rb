class RoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :reciprocal_following?, only: [:create]

  def create
    @room=Room.create
    other_user=User.find(params[:user_id])
    # binding.pry
    if @room.room_relations.create(user_id: other_user.id)
      if @room.room_relations.create(user_id: current_user.id)
        redirect_to user_room_path(other_user,@room)
      else
        @room.destory
        redirect_to user_path(other_user)
      end
    else
      @room.destroy
      redirect_to user_path(other_user)
    end


  end

  def show
    @user=User.find(params[:user_id])
    @room=Room.find(params[:id])
  end

  private

  def reciprocal_following?
    user = User.find(params[:user_id])
    redirect_to books_path unless current_user.following?(user)  && user.following?(current_user)
  end

end
