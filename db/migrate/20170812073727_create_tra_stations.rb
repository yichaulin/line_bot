class CreateTraStations < ActiveRecord::Migration[5.0]
  def change
    create_table :tra_stations do |t|
      t.integer :station_id
      t.string  :station_name
      t.string  :station_en_name
      t.timestamps
    end
  end
end
