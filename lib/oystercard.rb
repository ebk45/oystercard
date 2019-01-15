class Oystercard
  
  attr_reader :balance, :monies

  def initialize(balance = 0)
    @balance = balance
  end

  def top_up(monies)
    fail 'Maximum balance is exceeded' if (@balance + monies) >= 91
    @balance += monies
  end



end
