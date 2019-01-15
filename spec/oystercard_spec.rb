require 'oystercard'

RSpec.describe Oystercard do


    it 'should have a balance of 0 by default' do
      expect(subject.balance).to eq(0)
    end

  describe '#top_up' do

    it { is_expected.to respond_to(:top_up).with(1).argument }

    it 'should return a new balance when monies are added' do
      expect{subject.top_up 1 }.to change { subject.balance }.by 1
    end

    it 'should raise an error when the maximum balance is exceeded' do
      expect { subject.top_up 91 }.to raise_error('Maximum balance is exceeded')
    end
    

  end
end
