$LOAD_PATH << "#{File.expand_path("../../lib", __FILE__)}"

require 'connect_four.rb'

describe ConnectFour do
  before(:each) do
    @game = ConnectFour.new
  end

  describe "#print_board" do
    it "prints out a board that's 7 row's by 6 column's large" do
      board_double = double('board_double', :test => File.read("print_board_string.txt"))
      expect {@game.print_board}.to output(board_double.test).to_stdout
    end
  end

  #describe "#play" do
  #  it "runs the alternate_turns method" do
  #    expect(@game).to receive(:player_turn)
  #    @game.alternate_turns
  #  end
  #end


end