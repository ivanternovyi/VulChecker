class MailToUsersService
  def call
    User.find_each do |user|
      UsersMailer.notify_with_vulnerabilities(user).deliver_later
    end
  end
end
