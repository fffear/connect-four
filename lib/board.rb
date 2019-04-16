$LOAD_PATH << '.'
require 'board_tiles.rb'
require 'vertical_win.rb'
require 'horizontal_win.rb'
require 'diagonal_up_right_win.rb'
require 'diagonal_up_left_win.rb'

class Board
  attr_accessor :board, :vertex_list, :adjacency_list

  def initialize
    @vertex_list = []
    @adjacency_list = Array.new(42, [])
  end

  def create_vertex_list_row(row)
    (0..6).each { |n| vertex_list << BoardTiles.new([n, row], " ") }
  end

  def create_vertex_list
    (0..5).each { |n| create_vertex_list_row(n) }
  end

  def create_adjacency_list
    (0..41).each(&determine_adjacent_tiles)
  end

  def print_board
    (6).downto(0).each(&print_individual_row)
  end

  #victory conditions
  def victory?
    vertical_win? || horizontal_win? || diagonal_win?
  end

  def vertical_win?
    VerticalWin.new(vertex_list, adjacency_list).compute
  end

  def horizontal_win?
    HorizontalWin.new(vertex_list, adjacency_list).compute
  end

  def diagonal_win?
    diagonal_up_left_win? || diagonal_up_right_win?
  end

  def diagonal_up_left_win?
    DiagonalUpLeftWin.new(vertex_list, adjacency_list).compute
  end

  def diagonal_up_right_win?
    DiagonalUpRightWin.new(vertex_list, adjacency_list).compute
  end

  def draw?
    (41).downto(0).none? { |n| vertex_list[n].marker == " " } && !victory?
  end

  private
  # query and helper functions to create adjacency list
  def top_row?(n)
    @vertex_list[n].coordinates[1] == 5
  end
  
  def last_column?(n)
    @vertex_list[n].coordinates[0] == 6
  end
  
  def first_column?(n)
    @vertex_list[n].coordinates[0] == 0
  end
  
  def add_adjacent_top_tile(n)
    @adjacency_list[n] += [@vertex_list[n + 7]]
  end
  
  def add_adjacent_right_tile(n)
    @adjacency_list[n] += [@vertex_list[n + 1]]
  end
  
  def add_adjacent_diagonal_top_right_tile(n)
    @adjacency_list[n] += [@vertex_list[n + 8]]
  end
  
  def add_adjacent_diagonal_top_left_tile(n)
    @adjacency_list[n] += [@vertex_list[n + 6]]
  end
  
  def determine_adjacent_tiles
    lambda do |n|
      add_adjacent_top_tile(n) unless top_row?(n)
      add_adjacent_right_tile(n) unless last_column?(n)
      add_adjacent_diagonal_top_right_tile(n) unless top_row?(n) || last_column?(n)
      add_adjacent_diagonal_top_left_tile(n) unless first_column?(n) || top_row?(n)
    end
  end
  
  # helper functions to print board on command line
  def generate_row(num)
    row = " |"
    (start_of_row(num)..end_of_row(num)).each do |n| row << " " + @vertex_list[n].marker + " |" end
    row
  end

  def row_separator
    " +---+---+---+---+---+---+---+"
  end

  def column_numbers
    "   0   1   2   3   4   5   6"
  end

  def start_of_row(grid_row)
    ((grid_row + 1) * 7) - 7
  end
  
  def end_of_row(grid_row)
    ((grid_row + 1) * 7) - 1
  end

  def print_individual_row
    lambda { |n| puts (n.zero?) ? "#{row_separator}\n#{column_numbers}" : "#{row_separator}\n#{generate_row(n - 1)}" }
  end
end


#test = Board.new
#test.create_vertex_list
#test.create_adjacency_list
#test.print_board
#
#test.vertex_list[6].marker = "X"
#test.vertex_list[41].marker = "O"
#test.vertex_list[35].marker = "K"
#
#
#test.print_board
#test.adjacency_list[0].each do |v| puts v end

#p test.vertex_list[4].marker = "X"
#test.vertex_list[0].marker = "X"
#test.vertex_list[2].marker = "X"
#p test.vertex_list
#test.print_board