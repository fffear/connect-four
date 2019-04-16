$LOAD_PATH << "#{File.expand_path("../../lib", __FILE__)}"

require 'board_tiles.rb'
require 'player.rb'

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