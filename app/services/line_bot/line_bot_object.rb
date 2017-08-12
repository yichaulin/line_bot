module LineBot::LineBotObject
  def sticker_object(sticker_obj = LineSticker.all.sample)
    {
      type: 'sticker',
      packageId: sticker_obj.stk_pkg_id,
      stickerId: sticker_obj.stk_id
    }
  end

  def text_object(text = "Excuse me?")
    {
      type: 'text',
      text: text
    }
  end

  def img_object(url)
    {
      "type": "image",
      "originalContentUrl": url,
      "previewImageUrl": url
    }
  end

  def client
    Line::Bot::Client.new { |config|
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
      config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
    }
  end
end
