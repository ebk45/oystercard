require 'oystercard'

RSpec.describe Oystercard do

  let(:station) { double(:station) }

  it '1. should have an empty list of journeys by default' do
    expect(subject.journeys).to eq []
  end

  it '2. should have a balance of 0 by default' do
    expect(subject.balance).to eq 0
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
    before(:each) do
      @card = Oystercard.new
      @card.top_up(5)
    end
    it '1. should touch in the card' do
      expect(@card).to respond_to(:touch_in)
    end

    it '2. should raise an error when card does not have minimum balance' do
      min = Oystercard::MIN_BALANCE
      expect { subject.touch_in(:station) }.to raise_error "You need to have a minimum of £#{min}.00 to travel"
    end
  end

  describe '#touch_out' do
    it '1. should touch out the card' do
      expect(subject).to respond_to(:touch_out)
    end

  context 'Recording Journeys:' do
    before(:each) do
      @card = subject
      @card.top_up(5)
    end
    it '1. should start journey when touched in' do
      @card.touch_in(:station)
      expect(@card.in_journey?).to eq(true)
    end

    it '2. should end journey when touched out' do
      @card.touch_in(:station)
      @card.touch_out(:station)
      expect(@card.in_journey?).to eq(false)
    end

    it '3. should deduct monies when touched out' do
      min = Oystercard::MIN_BALANCE
      expect{@card.touch_out(:station)}.to change{@card.balance}.by(-min)
    end

    it '4. should remember entry station after touch in' do
      expect(@card.touch_in(:station)).to eq(@card.entry_station)
    end

    it '5. should forget entry station after touch out' do
      @card.touch_in(:station)
      expect { @card.touch_out(:station) }.to change { @card.entry_station }.to([])
    end

    it '6. should show history of journeys' do
      @card.touch_in(:station)
      @card.touch_out(:station)
      expect(@card.journeys).to include({:station => :station})
    end
  end

  end
end
