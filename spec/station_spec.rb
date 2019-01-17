require 'station'

describe Station do
  let(:station) { described_class.new("station", 1) }
  it 'should know what zone a station is in' do
    expect(station.zone).to eq(1)
  end

  it 'should know what the station has been named' do
    expect(station.name).to eq("station")
  end
    
end
