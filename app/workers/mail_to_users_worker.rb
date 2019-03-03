class MailToUsersWorker
  include Sidekiq::Worker
  sidekiq_options retry: true

  def perform
    MailToUsersService.new.call
  end
end
