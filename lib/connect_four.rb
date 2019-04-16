$LOAD_PATH << "#{File.expand_path("..", __FILE__)}"

require 'board.rb'
require 'player.rb'

class ConnectFour
  attr_accessor :board, :player1, :player2, :column_num, :current_player

  def initialize
    @board = Board.new
    @player1 = Player.new("X")
    @player2 = Player.new("O")
    @board.create_vertex_list
    @board.create_adjacency_list
  end

  def print_board
    @board.print_board
  end

  def alternate_turns
    player_turn(1, @player1)
    board.print_board
    @current_player = 1
    return if board.victory? || board.draw?
    player_turn(2, @player2)
    board.print_board
    @current_player = 2
  end

  def play
    alternate_turns until @board.victory? || @board.draw?
    puts "Player #{@current_player} wins." if @board.victory?
    puts "Draw!" if @board.draw?
  end

  private
  def player_turn(num, player)
    prompt_player_for_column_to_drop_piece(num)
    player.drop_piece(board.vertex_list, column_num.to_i)
  end

  def prompt_player_for_column_to_drop_piece(num)
    loop do
      puts "Player #{num}: Please select a column to drop piece in:"
      @column_num = gets.chomp
      break if ("0".."6").include?(column_num)
      puts "Please enter a column number from 0 to 6." if !("0".."6").include?(column_num)
    end
  end
end

# game = ConnectFour.new
# game.board.print_board
# game.play