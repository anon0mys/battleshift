class Api::V1::Games::ShipsController < ApiController
  def create
    game   = Game.find(params['game_id'])
    ship   = Ship.new(params['ship_size'], params['start_space'], params['end_space'])
    board  = game.determine_player_board(validate_player)
    placer = ShipPlacer.new(board, ship)
    placer.run
    render json: game, message: placer.message
    game.save!
  end
end
