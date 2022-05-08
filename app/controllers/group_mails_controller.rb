class GroupMailsController < ApplicationController
  def new
    @group_mail=GroupMail.new()
    @group=Group.find(params[:group_id])
  end

  def create
    group=Group.find(params[:group_id])
    # binding.pry
    group.group_members.each do |member|
      # binding.pry
      group_mail=GroupMail.new(group_mail_params)
      group_mail.group_id=group.id
      group_mail.group_member_id=member.id
      # binding.pry
      if group_mail.save
        SendMailer.send_when_push(member.user,group_mail).deliver
      end
    end
    # binding.pry
    @mail=GroupMail.new(group_mail_params)
  end


  private

  def group_mail_params
    params.require(:group_mail).permit(:title,:body)
  end
end
