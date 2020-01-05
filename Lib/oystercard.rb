require_relative 'journey'
require_relative 'journey_log'
require_relative 'station'

class Oystercard
  attr_reader :balance, :journey_log

  MAXIMUM_BALANCE = 90
  MINIMUM_TOUCH_IN = 1

  def initialize(balance = 0, journey_log = JourneyLog.new)
    @balance = balance
    @journey_log = journey_log
  end

  def top_up(amount)
    raise 'Top Up above maximum' if balance_exceeded?(amount)

    @balance += amount
  end

  def touch_in(entry_station)
    raise 'insufficient funds' if insufficient_touch_in?

    if @journey_log.journeys.any?
      deduct(@journey_log.journeys.last.calc_fare) if in_journey?
    end
    @journey_log.start(entry_station)
  end

  def touch_out(exit_station)
    @journey_log.finish(exit_station)
    deduct(@journey_log.journeys.last.calc_fare)
  end

  private

  def balance_exceeded?(amount)
    MAXIMUM_BALANCE < @balance + amount
  end

  def insufficient_touch_in?
    MINIMUM_TOUCH_IN > @balance
  end

  def deduct(amount)
    @balance -= amount
  end

  def in_journey?
    !@journey_log.journeys.last.complete?
  end

  # def start_journey(entry_station)
  #   @journey_log.start(entry_station)
  # end

  # def end_journey(exit_station)
  #   start_journey(nil) if @journey_log.journeys.empty?
  #   start_journey(nil) if !in_journey?
  #   @journey_log.finish(exit_station)
  # end
end
