class Api::V1::GamesController < ApiController
  def show
    game = Game.find(params[:id])
    render json: game
  end

  def create
    player_1 = PlayerDecorator.new(set_player, Board.new(4))
    player_2 = PlayerDecorator.new(set_opponent(params[:opponent_email]), Board.new(4))

    render json: Game.create({
      player_1_board: player_1.board,
      player_2_board: player_2.board,
      current_turn: 'player_1',
      player_1: player_1.id,
      player_2: player_2.id
      })
      binding.pry
  end

  private

  def set_opponent(email)
    User.find_by(email: email)
  end
end
