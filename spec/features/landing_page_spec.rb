require 'rails_helper'

describe 'when I visit /' do
  it 'has selector for location' do
    visit '/'
    expect(page).to have_select('location')
  end

  it 'takes you to /search when I select Griffin Coffee' do
    json_response = File.read('spec/fixtures/nearest_fuel.json')
    stub_request(:get, "https://developer.nrel.gov/api/alt-fuel-stations/v1/nearest.json?api_key=#{Rails.application.credentials.fuel[:key]}&fuel_type=ELEC&limit=1&location=5224%20W%2025th%20Ave,%20Denver,%20CO%2080214").
    with(
      headers: {
     'Accept'=>'*/*',
     'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
     'User-Agent'=>'Faraday v2.8.1'
      }).
    to_return(status: 200, body: json_response, headers: {})
    json_response1 = File.read('spec/fixtures/direction.json')
    stub_request(:get, "https://www.mapquestapi.com/directions/v2/route?from=5224%20W%2025th%20Ave,%20Denver,%20CO%2080214&key=#{Rails.application.credentials.mapquest[:key]}&to=5505%20W%2020th%20Ave,%20Edgewater,%20CO%2080214").
         with(
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Faraday v2.8.1'
           }).
         to_return(status: 200, body: json_response1, headers: {})
    visit '/'
    select('Griffin Coffee')
    click_button('Find Nearest Station')
    expect(current_path).to eq('/search')
    expect(page).to have_content('Name: Edgewater Public Market - Tesla Supercharger')
    expect(page).to have_content('Address: 5505 W 20th Ave, Edgewater, CO 80214')
    expect(page).to have_content('Fuel Type: ELEC')
    expect(page).to have_content('Access Times: 24 hours daily')
  end

  it 'should also tell you directions to the nearest station' do
    json_response = File.read('spec/fixtures/nearest_fuel.json')
    stub_request(:get, "https://developer.nrel.gov/api/alt-fuel-stations/v1/nearest.json?api_key=#{Rails.application.credentials.fuel[:key]}&fuel_type=ELEC&limit=1&location=5224%20W%2025th%20Ave,%20Denver,%20CO%2080214").
    with(
      headers: {
     'Accept'=>'*/*',
     'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
     'User-Agent'=>'Faraday v2.8.1'
      }).
    to_return(status: 200, body: json_response, headers: {})

    json_response1 = File.read('spec/fixtures/direction.json')
    stub_request(:get, "https://www.mapquestapi.com/directions/v2/route?from=5224%20W%2025th%20Ave,%20Denver,%20CO%2080214&key=#{Rails.application.credentials.mapquest[:key]}&to=5505%20W%2020th%20Ave,%20Edgewater,%20CO%2080214").
         with(
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Faraday v2.8.1'
           }).
         to_return(status: 200, body: json_response1, headers: {})

    visit '/'
    select('Griffin Coffee')
    click_button('Find Nearest Station')
    expect(page).to have_content('Distance: 0.7077 miles')
    expect(page).to have_content('Travel Time: 3 minutes')
    expect(page).to have_content('Directions: Head toward W 25th Ave. Go for 69 ft. Turn right onto W 25th Ave. Go for 177 ft. Turn right onto Sheridan Blvd (CO-95). Go for 0.4 mi. Turn right onto W 20th Ave. Go for 0.1 mi. Take the 2nd exit from roundabout onto W 20th Ave. Go for 479 ft. Turn right. Go for 420 ft. and Arrive at your destination.')
  end
end