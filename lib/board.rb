require "./lib/player.rb"

class Board
  attr_accessor :p1, :p2

  def initialize(name1 = "Player 1", name2 = "Player 2")
    @board = Array.new(6) { Array.new(7, '  ') }
    @red = "🔴"
    @blue = "🔵"
    @p1 = Player.new(name1)
    @p2 = Player.new(name2)
  end

  def play
    draw_board

    loop do
      turn_p1
      draw_board
      if check_winner
        @p1.is_win = true
        announce_winner
        break
      end
      turn_p2
      draw_board
      if check_winner
        @p2.is_win = true
        announce_winner
        break
      end
    end

  end

  def announce_winner
    puts "#{@p1.name} wins!" if @p1.is_win
    puts "#{@p2.name} wins!" if @p2.is_win
  end

  def turn_p1
    puts "#{@p1.name}'s turn:"
    input = ""
    loop do
      input = gets.chomp
      break if input_valid?(input)
      puts "Input invalid! Try again:"
    end
    drop_ball(input.to_i, @red)
  end

  def turn_p2
    puts "#{@p2.name}'s turn:"
    input = ""
    loop do
      input = gets.chomp
      break if input_valid?(input)
      puts "Input invalid! Try again:"
    end
    drop_ball(input.to_i, @blue)
  end

  def draw_board
    @board.each do |row|
      puts "| #{row.join(' | ')} |"
    end
    puts "| 1  | 2  | 3  | 4  | 5  | 6  | 7  |"
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

  def check_winner
    return true if check_vertically || check_horizontally || check_diagonally1 || check_diagonally2
    false
  end

  def check_vertically
    arr_red = Array.new(4, @red).join('')
    arr_blue = Array.new(4, @blue).join('')
    7.times do |i|
      arr = []
      @board.each do |row|
        arr << row[i]
      end
      return true if arr.join('').include?(arr_red) || arr.join('').include?(arr_blue)
    end
    false
  end

  def check_horizontally
    arr_red = Array.new(4, @red).join('')
    arr_blue = Array.new(4, @blue).join('')
    @board.each do |row|
      arr = []
      row.each do |i|
        arr << i
      end
      return true if arr.join('').include?(arr_red) || arr.join('').include?(arr_blue)
    end
    false
  end

  def check_diagonally1
    arr_red = Array.new(4, @red).join('')
    arr_blue = Array.new(4, @blue).join('')

    7.times do |a|
      6.times do |b|
        i = a
        j = b
        arr = []
        until j < 0
          arr << @board[j][i]
          j -= 1
          i += 1
        end
        return true if arr.join('').include?(arr_red) || arr.join('').include?(arr_blue)
      end
    end

    false
  end

  def check_diagonally2
    arr_red = Array.new(4, @red).join('')
    arr_blue = Array.new(4, @blue).join('')

    6.times do |a|
      7.times do |b|
        i = a
        j = b
        arr = []
        until j > 6 || i > 5
          arr << @board[i][j]
          j += 1
          i += 1
        end
        return true if arr.join('').include?(arr_red) || arr.join('').include?(arr_blue)
      end
    end

    false
  end
end
