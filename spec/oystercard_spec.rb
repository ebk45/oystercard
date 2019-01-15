require 'oystercard'

RSpec.describe Oystercard do


    it 'should have a balance of 0 by default' do
      expect(subject.balance).to eq(0)
    end

  describe '#top_up' do

    it 'should respond to top_up method' do
      expect(subject).to respond_to(:top_up)
    end





  end
end
