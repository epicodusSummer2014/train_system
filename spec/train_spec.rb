require 'spec_helper'

describe 'Station' do
  describe 'initialize' do
    it 'initializes a new station' do
      new_station = Station.new({:name => "151st & Gleason"})
      expect(new_station).to be_a Station
    end
  end

  describe 'save' do
    it 'saves a station' do
      new_station = Station.new({:name => "151st & Gleason"})
      new_station.save
      expect(Station.all).to eq [new_station]
    end
  end

  describe '.all' do
    it 'returns all of the stations' do
      new_station = Station.new({:name => "151st & Gleason"})
      new_station2 = Station.new({:name => "Fischers Landing"})
      new_station.save
      new_station2.save
      expect(Station.all).to eq [new_station, new_station2]
    end
  end

  describe '==' do
    it 'compares two stations for equality' do
      new_station = Station.new({:name => "151st & Gleason"})
      new_station2 = Station.new({:name => "151st & Gleason"})
      new_station.save
      new_station2.save
      expect(new_station.==(new_station2)).to eq true
    end
  end

  describe '.station_list' do
    it 'returns all of the stations on a given line' do
      new_station = Station.new({:name => "151st & Gleason"})
      new_station2 = Station.new({:name => "Fischers Landing"})
      new_station.save
      new_station2.save
      new_line = Line.new({:name => "Portland Express"})
      new_line2 = Line.new({:name => "Vancouver Express"})
      new_line.save
      new_line2.save
      new_station.update_train_lines(new_line.name)
      new_station.update_train_lines(new_line2.name)
      new_station2.update_train_lines(new_line.name)
      expect(Station.station_list("Portland Express")).to eq [new_station, new_station2]
    end
  end
end
