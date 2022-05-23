class DirectMessagesController < ApplicationController
  def create
    # binding.pry
    direct_messeage = current_user.direct_messages.new(direct_messeage_params)
    direct_messeage.room_id = params[:room_id]
    direct_messeage.save
    # binding.pry
    @room = direct_messeage.room
  end

  private

  def direct_messeage_params
    params.require(:direct_message).permit(:comment)
  end
end
