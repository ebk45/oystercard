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

  describe '#deduct' do
    it 'should deduct monies from the oystercard' do
      expect { subject.deduct 1 }.to change { subject.balance }.by -1
    end
  end


  end
end
