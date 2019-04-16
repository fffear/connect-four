$LOAD_PATH << "#{File.expand_path("../../lib", __FILE__)}"

require 'board_tiles.rb'
require 'board.rb'

describe Board do
  before(:each) do
    @board = Board.new
    @board.create_vertex_list
    @board.create_adjacency_list
  end

  def fill_board_to_draw
    (0..41).each do |n|
      @board.vertex_list[n].marker = "O" if (n % 7).even? && n <= 20 || (n % 7).odd? && n > 20
      @board.vertex_list[n].marker = "X" if (n % 7).odd? && n <= 20 || (n % 7).even? && n > 20
    end
    
  end

  describe "draw?" do
    it "returns false when there is no 4 in a row, and there are still blank tiles." do
      fill_board_to_draw
      @board.vertex_list[35].marker = " "
      @board.print_board
      expect(@board.draw?).to be false
    end

    it "returns true when there are no 4 in a row, and there are no blank tiles." do
      fill_board_to_draw
      @board.print_board
      expect(@board.draw?).to be true
    end
  end

  describe "#print_board" do
    it "prints a 7 column by 6 row board" do      
      board_double = double('board_double', :test => File.read("print_board_string.txt"))
      expect {@board.print_board}. to output( board_double.test).to_stdout
    end
  end

  describe "#create_vertex_list_row" do
    it "creates a row of 7 vertices(tiles)" do
      row = []
      (0..6).each { |n| row << BoardTiles.new([n, 0], " ") }
      row_double = double('row_double', :elements => row)
      expect(@board.vertex_list[0..6]).to eql(row_double.elements)
    end
  end

  describe "#create_vertex_list" do
    it "creates a complete vertex list that has 42 vertices(tiles)" do
      vertex_list = []
      (0..5).each do |num|
        (0..6).each { |n| vertex_list << BoardTiles.new([n, num], " ") }
      end
      vertex_list_double = double("vertex_list_double", :elements => vertex_list)
      expect(@board.vertex_list).to eql(vertex_list_double.elements)
    end
  end

  describe "#create_adjacency_list" do
    it "creates an adjacency list listing the edges between each tile" do
      adjacency_list = Array.new(42, [])
      vertex_list = []
      (0..5).each do |num|
        (0..6).each { |n| vertex_list << BoardTiles.new([n, num], " ") }
      end
      (0..41).each do |n|
        adjacency_list[n] += [vertex_list[n + 7]] unless vertex_list[n].coordinates[1] == 5 #top child
        adjacency_list[n] += [vertex_list[n + 1]] unless vertex_list[n].coordinates[0] == 6 #right child
        adjacency_list[n] += [vertex_list[n + 8]] unless vertex_list[n].coordinates[0] == 6 || vertex_list[n].coordinates[1] == 5 #diagonal right up child
        adjacency_list[n] += [vertex_list[n + 6]] unless vertex_list[n].coordinates[0] == 0 || vertex_list[n].coordinates[1] == 5 #diagonal right down child
      end
      
      adjacency_list_double = double('adjacency_list_double', :elements => adjacency_list)
      expect(@board.adjacency_list).to eql(adjacency_list_double.elements)
    end
  end
end