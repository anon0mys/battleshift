class Api::V1::GamesController < ApiController
  def show
    game = Game.find(params[:id])
    render json: game
  end

  def create
    player_1 = PlayerDecorator.new(User.find_by(api_key: request.headers['X-API-Key']), Board.new(4))
    player_2 = PlayerDecorator.new(User.find_by(email: params[:opponent_email]), Board.new(4))

    render json: Game.create({
      player_1_board: player_1.board,
      player_2_board: player_2.board,
      winner: nil,
      player_1_turns: 0,
      player_2_turns: 0,
      current_turn: 'player_1'
      })
  end
end
