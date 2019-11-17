class UserMailer < ApplicationMailer
  default from: 'rails-base@slowalk.co.kr'

  def hibernate_notify(user_id)
    @user = User.find(user_id)
    receiver = @user.email
    mail(to: receiver, subject: '[rails-base] 분리 보관 안내')
  end
end
