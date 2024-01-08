class MapService
  def conn
    Faraday.new(url: 'https://www.mapquestapi.com/')
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def direction(from, to)
    get_url("directions/v2/route?key=#{Rails.application.credentials.mapquest[:key]}&from=#{from}&to=#{to}")
  end
end