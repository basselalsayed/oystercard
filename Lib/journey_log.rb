require_relative 'journey'

class JourneyLog
  attr_reader :journey_class

  def initialize(journey_class)
    @journey_class = journey_class
    create_journeys
  end

  def start(entry_station)
    @journeys << @journey_class.new(entry_station)
  end
  
  def finish(exit_station)
    @journeys.last.end(exit_station)
  end

  def journeys
    @journeys
  end

 
  private

  def create_journeys
    @journeys = []
  end

  def current_journey
    return @journeys.last if !@journeys.last.complete?
    start(nil)
  end
 



end