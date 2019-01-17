require 'journey'

describe Journey do
  let(:entry_station) { double("station", name: "aldgate", zone: 1)}

  it '1. should log an entry station' do
    expect(subject.start(entry_station)).to eq(entry_station)
  end
end
