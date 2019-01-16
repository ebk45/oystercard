class Oystercard

  MAX_BALANCE = 90
  MIN_BALANCE = 1

  attr_reader :balance, :monies

  def initialize(balance = 0)
    @balance = balance
    @journey = false
  end

  def top_up(monies)
    fail "Maximum balance of £#{MAX_BALANCE}.00 is exceeded" if (@balance + monies) > MAX_BALANCE
    @balance += monies
  end

  def in_journey?
    @journey
  end

  def touch_in
    fail "You need to have a minimum of £#{MIN_BALANCE}.00 to travel" unless @balance >= MIN_BALANCE
    @journey = true
  end

  def touch_out
    deduct(MIN_BALANCE)
    @journey = false
  end
  private
  
  def deduct(monies)
    @balance -= monies
  end

end
