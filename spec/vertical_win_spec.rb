$LOAD_PATH << "#{File.expand_path("../../lib", __FILE__)}"

require 'vertical_win.rb'
require 'board.rb'
 
describe VerticalWin do
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
end