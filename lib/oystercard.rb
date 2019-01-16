class Oystercard

  MAX_BALANCE = 90
  MIN_BALANCE = 1

  attr_reader :balance, :monies, :entry_station, :journeys

  def initialize(balance = 0)
    @journeys = []
    @balance = balance
    @entry_station = []
  end

  def top_up(monies)
    fail "Maximum balance of £#{MAX_BALANCE}.00 is exceeded" if (@balance + monies) > MAX_BALANCE
    @balance += monies
  end

  def in_journey?
    @entry_station != []
  end

  def touch_in(entry_station)
    fail "You need to have a minimum of £#{MIN_BALANCE}.00 to travel" unless @balance >= MIN_BALANCE
    @entry_station << entry_station
  end

  def touch_out(exit_station)
    deduct(MIN_BALANCE)
    @journeys << { @entry_station.pop => exit_station }
  end
  private

  def deduct(monies)
    @balance -= monies
  end

end
