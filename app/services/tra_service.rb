class TraService
  def initialize(options = {})
    @host = 'http://ptx.transportdata.tw/MOTC/'
    @from_station = find_station_id(options[:from]) if options[:from]
    @to_station   = find_station_id(options[:to]) if options[:to]
    @base_datetime = options[:time].present? ? Time.zone.parse(options[:time]) : Time.zone.now
  end

  def next_train_info
    train_infos(1)
  end

  def train_infos(info_count = 5)
    query_date = @base_datetime.to_date
    time_table = get_time_table_between_station(@from_station, @to_station, query_date)
    time_table = get_time_table_between_station(@from_station, @to_station, query_date + 1.day) if time_table.size == 0

    trains = time_table.sort_by{ |t| t["OriginStopTime"]["DepartureTime"] }
                    .select{ |t| @base_datetime <= Time.zone.parse("#{@base_datetime.to_date} #{t["OriginStopTime"]["DepartureTime"]}") }
                    .first(info_count)

    msg = "近#{info_count}班列車: \n"
    trains.each do |train|
      msg += "#{train["DailyTrainInfo"]["TrainTypeName"]["Zh_tw"]} : #{train["OriginStopTime"]["DepartureTime"]}\n"
    end
    msg
  end

  private

  def get_time_table_between_station(from, to, time = Time.zone.now)
    query_date = time.to_date.strftime('%Y-%m-%d')
    api_url = "#{@host}/v2/Rail/TRA/DailyTimetable/OD/#{from}/to/#{to}/#{query_date}"

    res = RestClient.get(api_url)
    JSON.parse(res.body)
  end

  def find_station_id(station_name)
    station = TraStation.find_by(station_name: station_name)
    fail "wrong station name, #{station_name}" if station.blank?
    station.station_id
  end
end