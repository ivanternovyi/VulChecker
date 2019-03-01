class UsersMailer < ApplicationMailer

  def notify_with_vulnerabilities(user)
    @user = user
    mail(to: @user.email, subject: 'New vulnerabilities')
  end
end
