# frozen_string_literal: true

require_relative 'journey'

class JourneyLog
  attr_reader :journey_class

  def initialize(journey_class = Journey)
    @journey_class = journey_class
    create_journeys
  end

  def start(entry_station)
    @journeys << @journey_class.new(entry_station)
  end
  
  def finish(exit_station)
    current_journey.end(exit_station)
  end

  def journeys
    @journeys.clone
  end

  private

  def create_journeys
    @journeys = []
  end

  def current_journey
    if @journeys.any? && !@journeys.last.complete?
      @journeys.last 
    else
      start(nil).last
    end
  end
end
