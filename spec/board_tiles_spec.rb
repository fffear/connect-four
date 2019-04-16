$LOAD_PATH << "#{File.expand_path("../../lib", __FILE__)}"

require 'board_tiles.rb'

describe BoardTiles do
  before(:each) { @tile = BoardTiles.new([0, 0], " ") }

  describe "#coordinates" do
    it "returns a new vertex with '0' as the 'x' and 'y' coordinates" do
      expect(@tile.coordinates).to eql([0, 0]) 
    end
  end

  describe "#marker" do
    it "returns a blank string." do
      expect(@tile.marker).to eql(" ")
    end
  end
end