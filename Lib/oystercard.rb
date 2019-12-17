class Oystercard

attr_reader :balance
MAXIMUM_BALANCE = 90

def initialize(balance = 0, maximum_balance = MAXIMUM_BALANCE)
  @balance = balance
  @maximum_balance = maximum_balance
end


  def top_up(amount)
    raise "Top Up above maximum" if balance_exceeded?(amount)
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end


private

  def balance_exceeded?(amount)
    @maximum_balance < @balance + amount
  end

end
