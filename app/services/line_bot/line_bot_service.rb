require 'line/bot'
require 'active_support'

module LineBot
  class LineBotService
    include LineBotObject

    attr_reader :event_type
    def initialize(event)
      @event = event
      parse_event
    end

    def reply_message(option = {})
      reply_object = case @message_obj["type"]
                     when "text"
                       text_object(@return_text)
                     when "sticker"
                       sticker_object
                     else
                       text_object
                     end

      reply_object = img_object(@img_url) if @img_url

      response = client.reply_message(@reply_token, reply_object)
      p response
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
      words = @message_obj['text'].try(:split)
      return if words.blank?

      if words.include?('開團')
        words.delete('開團')
        store = Store.find_by(ch_name: words.first)
        @img_url = store.menu.url
      elsif query_tra?(words)
        words.delete('台鐵')
        words.delete('臺鐵')
        @return_text = TraService.new(from: words[0], to: words[1]).train_infos
      end
    end

    def parse_reply_token
      @reply_token = @event["replyToken"]
      fail "no reply token" if @reply_token.blank?
    end

    def query_tra?(words)
      words.include?('台鐵') || words.include?('臺鐵')
    end
  end
end
