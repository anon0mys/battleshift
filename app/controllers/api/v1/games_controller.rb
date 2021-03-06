class Api::V1::GamesController < ApiController
  def show
    game = Game.find(params[:id])
    render json: game
  end

  def create
    player_1 = PlayerDecorator.new(set_player, Board.new(4))
    player_2 = PlayerDecorator.new(set_opponent(params[:opponent_email]), Board.new(4))

    render json: Game.create({
      player_1_board: Board.new(4),
      player_2_board: Board.new(4),
      current_turn: 'player_1',
      player_1: set_player,
      player_2: set_opponent(params[:opponent_email])
    })
  end

  private

  def set_opponent(email)
    user = User.find_by(email: email)
    if user.nil?
      user = User.new(name: 'Artie', email: 'comp@ai.com', password: 'password')
      user.set_api_key
      user.save
    end
    user
  end
end
