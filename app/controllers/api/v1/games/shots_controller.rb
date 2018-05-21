class Api::V1::Games::ShotsController < ApiController

  def create
    @game = Game.find(params[:game_id])
    turn_processor = TurnProcessor.new(@game, params[:shot][:target], set_player)

    turn_processor.run!
    render json: @game, message: turn_processor.message, status: turn_processor.status
  end
end
