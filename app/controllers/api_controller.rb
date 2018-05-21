class ApiController < ActionController::API
  include ActionController::Helpers
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from ApiExceptions::InvalidApiKey, with: :unauthorized
  # rescue_from ApiExceptions::InvalidPlayer, with: :invalid_player
  helper_method :set_player, :set_game

  def set_player
    @player = User.find_by(api_key: request.headers['X-API-Key'])
    raise ApiExceptions::InvalidApiKey.new('Unauthorized', 401) if @player.nil?
    @player
  end

  def not_found
    render file: "#{Rails.root}/public/404.html", status: 400
  end

  def unauthorized(exception)
    render json: { message: exception.message }, status: 401
  end

  def invalid_player(exception)
    # render json: { message: exception.message }, status: 200
  end

  def set_game
    @game ||= Game.find(params['game_id'])
  end

  def validate_player
    player = set_player
    unless player == set_game.player_1 || player == set_game.player_2
      # raise ApiExceptions::InvalidPlayer.new('You are not a player in this game', 200)
    end
    player
  end
end
