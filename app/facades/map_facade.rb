class MapFacade
  def direction(from, to)
    data = MapService.new.direction(from, to)
    MapDirection.new(data)
  end
end