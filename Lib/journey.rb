class Journey
  attr_reader :entry_station, :exit_station

  MINIMUM_FARE = 2
  PENALTY_FARE = 6

  def initialize(entry_station)
    @entry_station = entry_station
  end

  def end(exit_station)
    @exit_station = exit_station
  end

  def calc_fare
    complete? ? MINIMUM_FARE : PENALTY_FARE
  end

  def complete?
    !!@entry_station && !!@exit_station
  end


end
