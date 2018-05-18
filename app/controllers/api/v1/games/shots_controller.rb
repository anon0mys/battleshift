class Api::V1::Games::ShotsController < ApiController

  def create
    @player = User.find_by(api_key: request.headers['X-API-Key'])
    raise ApiExceptions::InvalidApiKey.new('Unauthorized', 401) if @player.nil?
    @game = Game.find(params[:game_id])
    turn_processor = TurnProcessor.new(@game, params[:shot][:target], @player)

    turn_processor.run!
    render json: @game, message: turn_processor.message
  end
end
