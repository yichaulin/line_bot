class TraStation < ApplicationRecord
  def self.fetch_stations
    res = RestClient.get('http://ptx.transportdata.tw/MOTC/v2/Rail/TRA/Station')
    JSON.parse(res.body).each do |station|
      find_or_create_by(
        station_id: station["StationID"],
        station_name: station["StationName"]["Zh_tw"],
        station_en_name: station["StationName"]["En"])
    end
  end
end
