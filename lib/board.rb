class Board
  def initialize(name1 = "Player 1", name2 = "Player 2")
    @board = Array.new(6) { Array.new(7, '  ') }
  end

  def draw_board
    @board.each do |row|
      puts "| #{row.join(' | ')} |"
    end
  end

  def drop_ball(column, ball)
    high = check_high(column)
    @board[5 - high][column - 1] = ball
  end

  def check_high(column)
    counter = 0
    @board.each do |row|
      counter+= 1 unless row[column - 1] == "  "
    end
    counter
  end

  def input_valid?(column)
    return false if check_high(column.to_i) == 6
    return false unless column.to_i.is_a?(Integer)
    return false if column.to_i > 7 || column.to_i < 1
    true
  end
end
