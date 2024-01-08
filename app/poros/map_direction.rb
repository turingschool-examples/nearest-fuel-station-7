class MapDirection
  def initialize(data)
    @data = data
  end

  def distance
    @data[:route][:distance]
  end

  def travel_time
    ((@data[:route][:time])/60.to_f).round(0)
  end

  def instruction
    direction = []
    @data[:route][:legs][0][:maneuvers].each do |section|
      direction << section[:narrative]
    end
    direction.to_sentence.delete(',')
  end
end