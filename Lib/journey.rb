class Journey
  attr_reader :entry_station, :exit_station

  MINIMUM_FARE = 1
  PENALTY_FARE = 6
  
  def initialize(entry_station)
    @entry_station = entry_station
  end

  def end(exit_station)
    @exit_station = exit_station
  end

  def calc_fare
    complete? ? (MINIMUM_FARE + zone_fare) : PENALTY_FARE
  end

  def complete?
    !!@entry_station && !!@exit_station
  end

  def zone_fare
    zone_fare = (@entry_station.zone - @exit_station.zone).abs 
    zone_fare == 0 ? 1 : zone_fare  
  end

end
