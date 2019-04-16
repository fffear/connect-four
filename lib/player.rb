class Player
  attr_accessor :marker
  def initialize(marker)
    @marker = marker
  end

  def drop_piece(array, column)
    return puts "Column #{column} is full." if [0, 35].all? { |n| array[column + n].marker != " " }
    [35, 28, 21, 14, 7].each { |num| return array[column + num].marker = marker if array[column + (num - 7)].marker != " " }
    array[column].marker = marker if array[column].marker == " "
  end
end


#array = Array.new(42, " ")
#player = Player.new("X")
#player.drop_piece(array, 0)
#p array