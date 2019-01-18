require_relative 'station'

class Journey

  PENALTY_CHARGE = 6
  MINIMUM_FARE = 1

  def initialize
    @entry_station = nil
    @exit_station = nil
  end

  def start(entry_station)
    @entry_station = entry_station
  end

  def exit(exit_station)
    @exit_station = exit_station
  end

  def complete?
    if @entry_station.nil? || @exit_station.nil?
      return false
    end

    true
  end

  def fare
    return PENALTY_CHARGE unless complete?

    zones = [@entry_station.zone, @exit_station.zone].minmax
    zones_travelled = zones.last - zones.first
    zones_travelled * MINIMUM_FARE
  end

end
