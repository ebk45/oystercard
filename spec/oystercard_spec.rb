require 'oystercard'

RSpec.describe Oystercard do

  let(:entry_station) { double(:station) }
  let(:exit_station) { double(:station) }

  before(:each) do
    subject.top_up(5)
  end

  describe '#top_up' do
    it '1. should return a new balance when monies are added' do
      expect { subject.top_up 1 }.to change { subject.balance }.by 1
    end

    it '2. should raise an error when the maximum balance is exceeded' do
      max = Oystercard::MAX_BALANCE
      expect { subject.top_up max + 1 }.to raise_error("Maximum balance of £#{max}.00 is exceeded")
    end
  end

  describe '#touch_in' do
    it '1. should touch in the card' do
      expect(subject).to respond_to(:touch_in)
    end

    it '2. should raise an error when card does not have minimum balance' do
      min = Oystercard::MIN_BALANCE
      subject.instance_variable_set(:@balance, 0)
      expect { subject.touch_in(:entry_station) }.to raise_error "You need to have a minimum of £#{min}.00 to travel"
    end

    it '3. should remember entry station after touch in' do
      subject.touch_in(:entry_station)
      expect(subject.journeys.last[:entry]).to eq(:entry_station)
    end

  end

  describe '#touch_out' do
    before(:each) do
      subject.touch_in(:entry_station)
    end
    it '1. should touch out the card' do
      expect(subject).to respond_to(:touch_out)
    end

    it '2. should deduct monies when touched out' do
      min = Oystercard::MIN_BALANCE
      expect { subject.touch_out(:exit_station) }.to change { subject.balance }.by(-min)
    end

    it '3. should show history of journeys' do
      subject.touch_out(:exit_station)
      expect(subject.journeys).to include({ entry: :entry_station, exit: :exit_station })
    end
  end
end
