class Store < ApplicationRecord
  include Rails.application.routes.url_helpers
  mount_uploader :menu, MenuUploader

  def menu_full_url
    image_url(menu.url)  
  end
end
