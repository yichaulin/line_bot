class LineSticker < ApplicationRecord
  validates_presence_of :stk_id, :stk_pkg_id
end
