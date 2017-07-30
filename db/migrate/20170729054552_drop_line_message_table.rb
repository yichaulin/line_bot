class DropLineMessageTable < ActiveRecord::Migration[5.0]
  def change
    drop_table :line_messages
  end
end
