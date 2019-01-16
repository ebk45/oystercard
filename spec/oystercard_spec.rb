require 'oystercard'

RSpec.describe Oystercard do
    it 'should have a balance of 0 by default' do
      expect(subject.balance).to eq(0)
    end

  describe '#top_up' do
    it 'should return a new balance when monies are added' do
      expect { subject.top_up 1 }.to change { subject.balance }.by 1
    end

    it 'should raise an error when the maximum balance is exceeded' do
      max = Oystercard::MAX_BALANCE
      expect { subject.top_up max + 1 }.to raise_error("Maximum balance of £#{max}.00 is exceeded")
    end
  end

  describe '#in_journey' do
    it 'should be false when a new card is created' do
      expect(subject.in_journey?).to eq(false)
    end
  end

  describe '#touch_in' do
    before(:each) do
      @card = Oystercard.new
      @card.top_up(5)
    end
    it 'should touch in the card' do
      expect(@card).to respond_to(:touch_in)
    end

    it 'should raise an error when card does not have minimum balance' do
      min = Oystercard::MIN_BALANCE
      expect { subject.touch_in }.to raise_error "You need to have a minimum of £#{min}.00 to travel"
    end
  end

  describe '#touch_out' do
    it 'should touch out the card' do
      expect(subject).to respond_to(:touch_out)
    end


  context '1. Card state should change during journey' do
    before(:each) do
      @card = subject
      @card.top_up(5)
    end
    it 'should start journey when touched in' do
      @card.touch_in
      expect(@card.in_journey?).to eq(true)
    end

    it 'should end journey when touched out' do
      @card.touch_in
      @card.touch_out
      expect(@card.in_journey?).to eq(false)
    end

    it 'should deduct monies when touched out' do
      min = Oystercard::MIN_BALANCE
      expect{@card.touch_out}.to change{@card.balance}.by(-min)
    end
  end

  end
end
