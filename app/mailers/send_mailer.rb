class SendMailer < ApplicationMailer
  
  def send_when_push(user,group_mail)
    @user = user
    @group_mail = group_mail
    mail to: user.email,
         subject: "管理者からお知らせがあります"
  end

end
