require 'Qt4'
require 'player'
require 'game'

a = Qt::Application.new(ARGV)

game = Bingo::Game.new

numbers = (1..25).to_a.shuffle
player1 = Bingo::Player.new(game)
player1.name = "Player 1"
player1.fill(numbers)
game.player1 = player1

numbers = (1..25).to_a.shuffle
player2 = Bingo::Player.new(game)
player2.name = "Player 2"
player2.fill(numbers)
game.player2 = player2
game.init

game.show
a.exec

exit