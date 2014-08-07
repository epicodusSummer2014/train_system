require 'spec_helper'

describe 'Line' do
  describe 'initialize' do
    it 'initializes a new line' do
      new_line = Line.new({:name => "Portland Express"})
      expect(new_line).to be_a Line
    end
  end

  describe 'save' do
    it 'saves a line' do
      new_line = Line.new({:name => "Portland Express"})
      new_line.save
      expect(Line.all).to eq [new_line]
    end
  end

  describe '.all' do
    it 'returns all of the lines' do
      new_line = Line.new({:name => "Portland Express"})
      new_line2 = Line.new({:name => "Vancouver Express"})
      new_line.save
      new_line2.save
      expect(Line.all).to eq [new_line, new_line2]
    end
  end

  describe '==' do
    it 'compares two lines for equality' do
      new_line = Line.new({:name => "Portland Express"})
      new_line2 = Line.new({:name => "Portland Express"})
      new_line.save
      new_line2.save
      expect(new_line.==(new_line2)).to eq true
    end
  end
end
