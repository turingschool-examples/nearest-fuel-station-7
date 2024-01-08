class FuelStation
  attr_reader :name,
              :address,
              :fuel_type,
              :access_time

  def initialize(data)
    @name = data[:fuel_stations][0][:station_name]
    @address = "#{data[:fuel_stations][0][:street_address]}, #{data[:fuel_stations][0][:city]}, #{data[:fuel_stations][0][:state]} #{data[:fuel_stations][0][:zip]}"
    @fuel_type = data[:fuel_stations][0][:fuel_type_code]
    @access_time = data[:fuel_stations][0][:access_days_time]
  end
end