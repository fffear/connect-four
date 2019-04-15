require './board_tiles.rb'
require './board.rb'
require './player.rb'

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

describe Board do
  before(:each) do
    @board = Board.new
    @board.create_vertex_list
    @board.create_adjacency_list
  end

  def fill_column_to_win(col, num_opposite_marker) # number of opposite markers
    numbers = [0, 7, 14, 21, 28, 35]
    unless num_opposite_marker.zero?
      numbers.each_with_index do |n, idx|
        @board.vertex_list[col + n].marker = "O"
        break if idx == num_opposite_marker
      end
    end
    numbers = numbers.drop(num_opposite_marker)
    numbers.each_with_index do |n, idx|
      @board.vertex_list[col + n].marker = "X"
      break if idx == 3
    end
  end

  def
  end

  describe "#horizontal_win?" do
    context "returns true if there are 4 in a row in the 1st row." do
      it "1st row" do
        @board.vertex_list[0].marker = "X"
        @board.vertex_list[1].marker = "X"
        @board.vertex_list[2].marker = "X"
        @board.vertex_list[3].marker = "X"
        expect(@board.horizontal_win?). to be true
      end
    end

    context "returns true if there are 4 in a row in the 1st row." do
      it "1st row" do
        @board.vertex_list[1].marker = "X"
        @board.vertex_list[2].marker = "X"
        @board.vertex_list[3].marker = "X"
        @board.vertex_list[4].marker = "X"
        expect(@board.horizontal_win?). to be true
      end
    end

    context "returns true if there are 4 in a row in the 1st row." do
      it "1st row" do
        @board.vertex_list[2].marker = "X"
        @board.vertex_list[3].marker = "X"
        @board.vertex_list[4].marker = "X"
        @board.vertex_list[5].marker = "X"
        expect(@board.horizontal_win?). to be true
      end
    end

    context "returns true if there are 4 in a row in the 1st row." do
      it "1st row" do
        @board.vertex_list[3].marker = "X"
        @board.vertex_list[4].marker = "X"
        @board.vertex_list[5].marker = "X"
        @board.vertex_list[6].marker = "X"
        expect(@board.horizontal_win?). to be true
      end
    end
  end

  describe "#vertical_win?" do
    context "returns true if there are 4 in a row in:" do
      (0..6).each do |n|
        it "column #{n}" do
          fill_column_to_win(n, 0)
          expect(@board.vertical_win?).to be true
        end
      end
    end

    context "returns true if the bottom marker is different and there are 4 in a row in:" do
      (0..6).each do |n|
        it "column #{n}" do
          fill_column_to_win(n, 1)
          expect(@board.vertical_win?).to be true
        end
      end
    end

    context "returns true if the bottom 2 markers is different and there are 4 in a row in:" do
      (0..6).each do |n|
        it "column #{n}" do
          fill_column_to_win(n, 2)
          expect(@board.vertical_win?).to be true
        end
      end
    end

    context "returns true if there are not in 4 a row in:" do
      (0..6).each do |n|
        it "column #{n}" do
          fill_column_to_win(n, 3)
          expect(@board.vertical_win?).to be_falsey
        end
      end
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

describe Player do
  before(:each) do
    @player = Player.new("X")
    @array = Array.new(42, " ")
    @vertex_list = []
    (0..5).each do |num|
      (0..6).each { |n| @vertex_list << BoardTiles.new([n, num], " ") }
    end
  end
  
  def fill_bottom_rows(num_of_row, col_num)
    (0..num_of_row).each { |n| @vertex_list[7 * (n) + col_num].marker = @player.marker }
  end

  describe "#drop_piece" do
    context "drops a piece onto the lowest row of a column" do
      (0..6).each do |n|
        it "column #{n}" do
          expect { @player.drop_piece(@vertex_list, n) }.to change{ @vertex_list[n].marker }.to(@player.marker)
        end
      end
    end

    context "drops a piece onto the 2nd row of a column if there's already a piece on the row below." do
      (0..6).each do |n|
        it "column #{n}" do
          fill_bottom_rows(0, n)
          expect { @player.drop_piece(@vertex_list, n) }.to change{ @vertex_list[n + 7].marker }.to(@player.marker)
          
        end
      end
    end

    context "drops a piece on the 3rd row of a column if there's already pieces on the rows below." do
      (0..6).each do |n|
        it "column #{n}" do
        fill_bottom_rows(1, n)
          expect { @player.drop_piece(@vertex_list, n) }.to change{ @vertex_list[n + 14].marker }.to(@player.marker)
        end
      end
    end

    context "drops a piece onto the 4th row of a column if there's already pieces on the rows below." do
      (0..6).each do |n|
        it "column #{n}" do
          fill_bottom_rows(2, n)
          expect { @player.drop_piece(@vertex_list, n) }.to change{ @vertex_list[n + 21].marker }.to(@player.marker)
        end
      end
    end

    context "drops a piece onto the 5th row of a column if there's already pieces on the rows below." do
      (0..6).each do |n|
        it "column #{n}" do
          fill_bottom_rows(3, n)
          expect { @player.drop_piece(@vertex_list, n) }.to change{ @vertex_list[n + 28].marker }.to(@player.marker)
        end
      end
    end

    context "drops a piece onto the 6th row of a column if there's already pieces on the rows below." do
      (0..6).each do |n|
        it "column #{n}" do
          fill_bottom_rows(4, n)
          expect { @player.drop_piece(@vertex_list, n) }.to change{ @vertex_list[n + 35].marker }.to(@player.marker)
        end
      end
    end

    context "returns message that the column is full." do
      (0..6).each do |n|
        it "column #{n}" do
          fill_bottom_rows(5, n)
          message = double("message", :display => "Column #{n} is full.\n")
          expect { @player.drop_piece(@vertex_list, n) }.to output(message.display).to_stdout
        end
      end
    end
  end
end

