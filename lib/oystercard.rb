class Oystercard

  MAX_BALANCE = 90

  attr_reader :balance, :monies

  def initialize(balance = 0)
    @balance = balance
    @journey = false
  end

  def top_up(monies)
    fail "Maximum balance of £#{MAX_BALANCE}.00 is exceeded" if (@balance + monies) > MAX_BALANCE
    @balance += monies
  end

  def deduct(monies)
    @balance -= monies
  end

  def in_journey?
    @journey
  end

  def touch_in
    @journey = true
  end

  def touch_out
    @journey = false
  end



end
