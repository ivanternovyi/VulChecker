class Telegram::WebhooksController < Telegram::Bot::UpdatesController
  def message(message)
    respond_with :message, text: 'Command not defined'
  end

  def start!(data = nil, *)
    respond_with :message, text: "Hello, #{subscription.name}! You are subscribed."
  end

  private

  def subscription
    @subscription ||= Subscription.find_by(telegram_id: from[:id]) || register_subscription
  end

  def register_subscription
    Subscription.find_or_create_by(
      name: from['first_name'],
      telegram_id: from[:id]
    )
  end
end
