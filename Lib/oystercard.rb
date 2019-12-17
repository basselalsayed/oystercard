require_relative 'station'

class Oystercard

attr_reader :balance, :entry_station

MAXIMUM_BALANCE = 90
MINIMUM_TOUCH_IN = 1
MINIMUM_FARE = 2

def initialize(balance = 0, maximum_balance = MAXIMUM_BALANCE)
  @balance = balance
  @maximum_balance = maximum_balance
  @entry_station = nil
end


  def top_up(amount)
    raise "Top Up above maximum" if balance_exceeded?(amount)
    @balance += amount
  end


  def touch_in(entry_station)
    raise "insufficient funds" if insufficient_touch_in?
    @entry_station = entry_station
    in_journey?
  end

  def touch_out
    deduct(MINIMUM_FARE)
    @entry_station = nil
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
    @entry_station != nil
  end


end
