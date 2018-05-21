# Create Users
user_1 = User.new(name: 'User 1', email: 'user_1@mail.com', password: 'password', status: 'active')
user_1.set_api_key
user_1.save!
user_2 = User.new(name: 'User 2', email: 'user_2@mail.com', password: 'password', status: 'active')
user_2.set_api_key
user_2.save!


# Create Boards
player_1_board = Board.new(4)
player_2_board = Board.new(4)

# Create Ships
sm_ship = Ship.new(2, 'A1', 'A2')
md_ship = Ship.new(3, 'B1', 'D1')

# Place Player 1 ships
ShipPlacer.new(player_1_board, sm_ship).run
ShipPlacer.new(player_1_board, md_ship).run

# Place Player 2 ships
ShipPlacer.new(player_2_board, sm_ship.dup).run
ShipPlacer.new(player_2_board, md_ship.dup).run

game_attributes = {
  player_1: user_1,
  player_2: user_2,
  player_1_board: player_1_board,
  player_2_board: player_2_board,
  player_1_turns: 0,
  player_2_turns: 0,
  current_turn: 'player_1'
}

game = Game.new(game_attributes)
game.save!
