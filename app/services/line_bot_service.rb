require 'line/bot'
require 'active_support'

class LineBotService
  attr_reader :event_type
  def initialize(event)
    @event = event
    parse_event
  end

  def reply_message(option = {})
    reply_object = case @message_obj["type"]
                   when "text"
                     text_object
                   when "sticker"
                     sticker_object
                   else
                     {type: 'text', text: "Excuse me?"}
                   end

    response = client.reply_message(@reply_token, reply_object)
    p response
  end

  def sticker_object(sticker_obj = LineSticker.all.sample)
    {
      type: 'sticker',
      packageId: sticker_obj.stk_pkg_id,
      stickerId: sticker_obj.stk_id
    }
  end

  def text_object(text = "#{@message_obj["text"]}...")
    {
      type: 'text',
      text: text.to_s
    }
  end

  def client
    Line::Bot::Client.new { |config|
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
      config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
    }
  end

  def message_type
    @message_obj["type"]
  end

  private

  def parse_event
    parse_reply_token
    parse_event_type
    parse_message_obj
  end

  def parse_event_type
    @event_type = @event["type"]
  end

  def parse_message_obj
    @message_obj = @event["message"]
  end

  def parse_reply_token
    @reply_token = @event["replyToken"]
    fail "no reply token" if @reply_token.blank?
  end
end
