$LOAD_PATH << "#{File.expand_path("../../lib", __FILE__)}"

require 'horizontal_win.rb'
require 'board.rb'

describe HorizontalWin do
  before(:each) do
    @board = Board.new
    @board.create_vertex_list
    @board.create_adjacency_list
  end

  def fill_row_to_win(row, num_opposite_marker)
    numbers = [0, 1, 2, 3, 4, 5, 6]
    unless num_opposite_marker.zero?
      numbers.each_with_index do |n, idx|
        @board.vertex_list[7 * row + n].marker = "O" if idx < 3
        @board.vertex_list[7 * row + n].marker = " " if idx == 3
        break if idx == num_opposite_marker
      end
    end
    numbers = numbers.drop(num_opposite_marker)
    numbers.each_with_index do |n, idx|
      @board.vertex_list[7 * row + n].marker = "X"
      break if idx == 3
    end
  end


  describe "#horizontal_win?" do
    context "returns true if there are 4 in a row." do
      (0..5).each do |n|
        it "row #{n}" do
          fill_row_to_win(n, 0)
          expect(@board.horizontal_win?). to be true
        end
      end
    end

    context "returns true if there is 1 other marker in a row where there are 4 in a row." do
      (0..5).each do |n|
        it "row #{n}" do
          fill_row_to_win(n, 1)
          expect(@board.horizontal_win?). to be true
        end
      end
    end

    context "returns true if there is 2 other marker in a row where there are 4 in a row.." do
      (0..5).each do |n|
        it "row #{n}" do
          fill_row_to_win(n, 2)
          expect(@board.horizontal_win?). to be true
        end
      end
    end

    context "returns true if there is 3 other marker in a row where there are 4 in a row.." do
      (0..5).each do |n|
        it "row #{n}" do
          fill_row_to_win(n, 3)
          expect(@board.horizontal_win?). to be true
        end
      end
    end

    context "returns false if there are not 4 in a row in the any row." do
      (0..5).each do |n|
        it "row #{n}" do
          fill_row_to_win(n, 4)
          expect(@board.horizontal_win?). to be false
        end
      end
    end
  end
end