require_relative 'station'

class Oystercard

attr_reader :balance, :entry_station
attr_accessor :history_of_journeys

MAXIMUM_BALANCE = 90
MINIMUM_TOUCH_IN = 1
MINIMUM_FARE = 2

def initialize(balance = 0, maximum_balance = MAXIMUM_BALANCE)
  @balance = balance
  @maximum_balance = maximum_balance
  @entry_station = nil
  @exit_station = nil
  @history_of_journeys = []
  @journey_hash = {:entry_station => nil, :exit_station => nil}
end


  def top_up(amount)
    raise "Top Up above maximum" if balance_exceeded?(amount)
    @balance += amount
  end


  def touch_in(entry_station)
    raise "insufficient funds" if insufficient_touch_in?
    start_journey(entry_station, nil)
    in_journey?
  end

  def touch_out(exit_station)
    deduct(MINIMUM_FARE)
    end_journey(nil, exit_station)
    in_journey?
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
    @journey_hash = {:entry_station => entry_station, :exit_station => nil}
    @history_of_journeys << @journey_hash
  end

  def end_journey(exit_station)
    last_journey = @history_of_journeys.last
      if last_journey[:exit_station] = nil
        last_journey = {:exit_station => exit_station}
        @history_of_journeys.last = last_journey
      else
        new_last_journey = { :entry_station => nil :exit_station => exit_station }
        @history_of_journeys << new_last_journey
      end
  end


end
