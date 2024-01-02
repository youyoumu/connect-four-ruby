require "./lib/board.rb"

puts "Welcome to Connect Four."
puts "Use key 1-7 to select board column."
puts "Player 1's color is red, Player 2's color is blue."
puts "Enter Player 1's name: "
p1 = gets.chomp
puts "Enter Player 2's name: "
p2 = gets.chomp
puts "Game start!"
game = Board.new(p1, p2)
game.play
