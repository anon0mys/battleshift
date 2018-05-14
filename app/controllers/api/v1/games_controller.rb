class Api::V1::GamesController < ApiController
  def show
    game = Game.find(params[:id])
    render json: game
  end
end
