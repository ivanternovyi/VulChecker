# IMPORTANT
# Need public url to set webhook for telegram bot
# you may use ngrok, then send telegram api request to set webhook:
# Telegram.bot.set_webhook(url: "#{ngrok_url}/telegram/653110429_AAGCE4I9UIu_WzcF35y3dL_whuuseIbRBKw")

class NotifyTelegramUsersService
  attr_reader :bot

  def initialize
    @bot = Telegram.bot
  end

  def call
    Subscription.find_each do |subscription|
      send_message(subscription.telegram_id)
    end
  end

  private

  def send_message(chat_id)
    bot.send_message(
      chat_id: chat_id,
      text: 'Hey, there are new vulnerabilities!'
    )
  end
end
