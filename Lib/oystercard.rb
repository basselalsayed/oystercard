require_relative 'journey'

class Oystercard

  attr_reader :balance
  attr_accessor :history_of_journeys

  MAXIMUM_BALANCE = 90
  MINIMUM_TOUCH_IN = 2

  def initialize(balance = 0, maximum_balance = MAXIMUM_BALANCE)
    @balance = balance
    @maximum_balance = maximum_balance
    @history_of_journeys = []
  end

  def top_up(amount)
    raise "Top Up above maximum" if balance_exceeded?(amount)
    @balance += amount
  end

  def touch_in(entry_station)
    raise "insufficient funds" if insufficient_touch_in?
    if @history_of_journeys.any?
      deduct(@history_of_journeys.last.calc_fare) unless @history_of_journeys.last.complete?
    end
    start_journey(entry_station)
  end

  def touch_out(exit_station)
    end_journey(exit_station)
    deduct(@history_of_journeys.last.calc_fare)
  end


private

  def balance_exceeded?(amount)
    @maximum_balance < @balance + amount
  end

  def insufficient_touch_in?
    MINIMUM_TOUCH_IN > @balance
  end

  def deduct(amount)
    @balance -= amount
  end

  def in_journey?
    !!@entry_station
  end

  def start_journey(entry_station)
    @history_of_journeys << Journey.new(entry_station)
  end

  def end_journey(exit_station)
    start_journey(nil) if @history_of_journeys.empty?
    start_journey(nil) if @history_of_journeys.last.complete?
    @history_of_journeys.last.end(exit_station)
  end


end
