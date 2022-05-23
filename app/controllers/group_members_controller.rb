class GroupMembersController < ApplicationController
  def create
    @group_member = current_user.group_members.new(group_id: params[:group_id])
    # binding.pry
    if @group_member.save
      redirect_to group_path(@group_member.group)
    end
  end

  def destroy
    GroupMember.find_by(group_id: params[:group_id], user_id: current_user.id).destroy
    redirect_to groups_path
  end
end
