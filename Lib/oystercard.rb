class Oystercard

attr_reader :balance
MAXIMUM_BALANCE = 90
MINIMUM_TOUCH_IN = 1
MINIMUM_FARE = 2

def initialize(balance = 0, maximum_balance = MAXIMUM_BALANCE)
  @balance = balance
  @maximum_balance = maximum_balance
  @in_journey = false
end


  def top_up(amount)
    raise "Top Up above maximum" if balance_exceeded?(amount)
    @balance += amount
  end


  def touch_in
    raise "insufficient funds" if insufficient_touch_in?
    @in_journey = true
  end

  def touch_out
    deduct(MINIMUM_FARE)
    @in_journey = false
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


end
