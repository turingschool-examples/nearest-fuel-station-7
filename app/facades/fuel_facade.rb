class FuelFacade
  def location(address)
    data = FuelService.new.nearest_fuel(address)
    FuelStation.new(data)
  end  
end