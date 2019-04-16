$LOAD_PATH << "#{File.expand_path("../lib", __FILE__)}"

require 'connect_four.rb'

game = ConnectFour.new

puts "Welcome to Connect Four!"
game.board.print_board
game.play




