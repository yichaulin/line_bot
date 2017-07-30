class CreateStores < ActiveRecord::Migration[5.0]
  def change
    create_table :stores do |t|
      t.string :en_name
      t.string :ch_name
      t.json :menu 

      t.timestamps
    end
  end
end
