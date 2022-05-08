class ApplicationMailer < ActionMailer::Base
  default from:      "グループ管理者",
          bcc:       "sample+sent@gmail.com",
          replay_to: "sample+reply@gmail.com"  
  
  layout 'mailer'
end
