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

  describe '#deduct' do
    it 'should deduct monies from the oystercard' do
      expect { subject.deduct 1 }.to change { subject.balance }.by -1
    end
  end

  describe '#in_journey' do
    it 'should be false when a new card is created' do
      expect(subject.in_journey?).to eq(false)
    end
  end

  describe '#touch_in' do
    it 'should touch in the card' do
      expect(subject).to respond_to(:touch_in)
    end
  end

  describe '#touch_out' do
    it 'should touch out the card' do
      expect(subject).to respond_to(:touch_out)
    end
  end


  context '1. Card state should change during journey' do
    it 'should start journey when touched in' do
      subject.touch_in
      expect(subject.in_journey?).to eq(true)
    end

    it 'should end journey when touched out' do
      subject.touch_in
      subject.touch_out
      expect(subject.in_journey?).to eq(false)
    end

  end
end
