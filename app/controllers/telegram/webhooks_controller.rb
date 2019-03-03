class Telegram::WebhooksController < Telegram::Bot::UpdatesController
  def message(message)
    respond_with :message, text: 'Command not defined'
  end

  def start!(data = nil, *)
    respond_with :message, text: "Hello, #{from['first_name']}! You are subscribed."
  end
end
