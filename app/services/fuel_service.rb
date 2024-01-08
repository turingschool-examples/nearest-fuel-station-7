class FuelService
  def conn
    Faraday.new(url: 'https://developer.nrel.gov/')
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def nearest_fuel(location)
    get_url("api/alt-fuel-stations/v1/nearest.json?api_key=#{Rails.application.credentials.fuel[:key]}&location=#{location}&fuel_type=ELEC&limit=1")
  end
end