$LOAD_PATH << "#{File.expand_path("../../lib", __FILE__)}"

require 'diagonal_up_right_win.rb'
require 'board.rb'


describe DiagonalUpRightWin do
  before(:each) do
    @board = Board.new
    @board.create_vertex_list
    @board.create_adjacency_list
  end

  def fill_diagonal_up_right_to_win(origin, num_opposite_marker)
    numbers = [0, 8, 16, 24, 32, 40]
    unless num_opposite_marker.zero?
      numbers.each_with_index do |n, idx|
        @board.vertex_list[origin + n].marker = "O"
        break if idx == num_opposite_marker
      end
    end
    numbers = numbers.drop(num_opposite_marker)
    numbers.each_with_index do |n, idx|
      @board.vertex_list[origin + n].marker = "X"
      break if idx == 3 || @board.vertex_list.index(@board.vertex_list[origin + n]) > 35 || @board.vertex_list.index(@board.vertex_list[origin + n]) % 7 == 6
    end
  end

  describe "#diagonal_up_right_win?" do
    context "returns true if there are 4 in a row diagonally in an up right pattern" do
      [1, 2, 3, 0, 7, 14].each do |n|
        it "From #{n}th position" do
          fill_diagonal_up_right_to_win(n, 0)
          expect(@board.diagonal_up_right_win?).to be true
        end
      end
    end
    
    context "returns true if there is 1 other marker in a row where there are 4 in a row diagonally in an up right pattern" do
      [1, 2, 0, 7].each do |n|
        it "from #{n}th position" do
          fill_diagonal_up_right_to_win(n, 1)
          expect(@board.diagonal_up_right_win?).to be true
        end
      end
    end
   
    context "returns true if there are 2 other markers in a row where there are 4 in a row diagonally in an up right pattern" do
      [0, 1].each do |n|
        it "from position #{n}" do
          fill_diagonal_up_right_to_win(n, 2)
          expect(@board.diagonal_up_right_win?).to be true
        end
      end
    end
    
    context "returns false if there are not 4 in a row diagonally in an up right pattern" do
      [0, 1, 7, 14].each do |n|
        it "from #{n}th position" do
          fill_diagonal_up_right_to_win(n, 3)
          expect(@board.diagonal_up_right_win?).to be false
        end
      end
    
      [2, 3].each do |n|
        it "from #{n}th position" do
          fill_diagonal_up_right_to_win(n, 2)
          expect(@board.diagonal_up_right_win?).to be false
        end
      end
    end
  end
end