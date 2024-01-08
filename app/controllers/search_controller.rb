class SearchController < ApplicationController
  def index
    @address = params[:location]
    @fuel_station = FuelFacade.new.location(@address)
    @facade = MapFacade.new.direction(@address, @fuel_station.address)
  end
end