class RoomsController < ApplicationController

  def create
    @room=Room.create
    other_user=User.find(params[:user_id])
    # binding.pry
    if @room.room_relations.create(user_id: other_user.id) 
      if @room.room_relations.create(user_id: current_user.id)
        redirect_to room_path(@room)
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
  end


end
