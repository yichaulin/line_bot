class LineBotsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:callbacks]
  def index
  end

  def callbacks
    if params["events"].present?
      params["events"].each do |event|
        line_bot_service = LineBotService.new(event)
        line_bot_service.reply_msg("#{line_bot_service.msg_text}...")
      end
    end

    render status: 200, plain: 'ok'
  end
end
