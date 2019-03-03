class NotifyTelegramUsersWorker
  include Sidekiq::Worker
  sidekiq_options retry: true

  def perform
    NotifyTelegramUsersService.new.call
  end
end
