class CreateLineStickers < ActiveRecord::Migration[5.0]
  def change
    create_table :line_stickers do |t|
      t.integer :stk_id
      t.integer :stk_pkg_id
      t.timestamps
    end
  end
end
