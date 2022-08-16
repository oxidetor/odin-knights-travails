require_relative './game'

game = Game.new
p game.knight_moves([0, 0], [7, 7])
p game.knight_moves([0, 0], [4, 3])
p game.knight_moves([2, 2], [5, 5])
p game.knight_moves([0, 0], [1, 2])
p game.knight_moves([0, 0], [3, 3])
p game.knight_moves([3, 3], [0, 0])
