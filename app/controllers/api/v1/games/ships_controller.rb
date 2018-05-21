class Api::V1::Games::ShipsController < ApiController
  def create
    game = Game.find(params['game_id'])
    ship = Ship.new(params['ship_size'], params['start_space'], params['end_space'])
    if request.headers["HTTP_X_API_KEY"] == User.find(game.player_1).api_key
      placer = ShipPlacer.new(game.player_1_board, ship)
      placer.run
      render json: game, message: placer.message
    elsif request.headers["HTTP_X_API_KEY"] == User.find(game.player_2).api_key
      placer = ShipPlacer.new(game.player_2_board, ship)
      placer.run
      render json: game, message: placer.message
    else
      render json: game, message: 'You are not a player in this game.'
    end
  end
end
