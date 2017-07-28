require 'line/bot'
require 'active_support'

class LineBotService
  attr_reader :msg_text
  def initialize(event)
    @event = event
    parse_event
  end

  def reply_msg(msg)
    message = {
      type: 'text',
      text: msg.to_s
    }

    response = client.reply_message(@reply_token, message)
    p response
  end

  def client
    Line::Bot::Client.new { |config|
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
      config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
    }
  end

  private

  def parse_event
    parse_reply_token
    parse_message
  end

  def parse_reply_token
    @reply_token = @event["replyToken"]
    fail "no reply token" if @reply_token.blank?
  end

  def parse_message
    message = @event["message"]
    return if message.blank?

    @msg_text = message["text"]
  end
end
