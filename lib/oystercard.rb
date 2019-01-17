class Oystercard

  MAX_BALANCE = 90
  MIN_BALANCE = 1

  attr_reader :balance, :monies, :journeys

  def initialize(balance = 0)
    @journeys = []
    @balance = balance
  end

  def top_up(monies)
    error_message = "Maximum balance of £#{MAX_BALANCE}.00 is exceeded"
    fail error_message if (@balance + monies) > MAX_BALANCE

    @balance += monies
  end

  def touch_in(entry_station)
    error_message = "You need to have a minimum of £#{MIN_BALANCE}.00 to travel"
    fail error_message unless @balance >= MIN_BALANCE

    @journeys << ({ entry: entry_station, exit: nil })
  end

  def touch_out(exit_station)
    deduct(MIN_BALANCE)
    @journeys.last[:exit] = exit_station
  end
  private

  def deduct(monies)
    @balance -= monies
  end

end
