class LineBotsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:callbacks]
  def index
  end

  def callbacks
    if params["events"].present?
      params["events"].each do |event|
        line_bot_service = LineBotService.new(event)
        line_bot_service.reply_message(host: request.base_url)
      end
    end

    render status: 200, plain: 'ok'
  end
end
