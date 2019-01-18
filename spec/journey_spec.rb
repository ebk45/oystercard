require 'journey'

describe Journey do
  let(:entry_station) { double("station", name: "aldgate", zone: 1) }
  let(:exit_station) { double("station", name: "aldgate", zone: 2) }

  it '1. should log an entry station' do
    expect(subject.start(entry_station)).to eq(entry_station)
  end

  it '2. should log an exit station' do
    expect(subject.exit(exit_station)).to eq(exit_station)
  end

  it '3. should check if the journey is incomplete' do
    subject.start(entry_station)
    expect(subject).to_not be_complete
  end

  it '4. should check if the journey is complete' do
    subject.start(entry_station)
    subject.exit(exit_station)
    expect(subject).to be_complete
  end

  it '5. should calculate the fare of a journey' do
    subject.start(entry_station)
    subject.exit(exit_station)
    expect(subject.fare).to eq(1)
  end

  it '6. should charge a penalty fare when journey is incomplete' do
    subject.start(entry_station)
    expect(subject.fare).to eq(6)
  end

end
