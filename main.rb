require "./lib/board.rb"

game = Board.new
mark = "⚫"
game.drop_ball(1, mark)
game.drop_ball(1, mark)
game.drop_ball(1, mark)
game.drop_ball(1, mark)
game.drop_ball(2, mark)
game.drop_ball(2, mark)
game.drop_ball(3, mark)
game.drop_ball(7, mark)

game.draw_board
