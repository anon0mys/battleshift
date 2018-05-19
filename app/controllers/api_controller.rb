class ApiController < ActionController::API
  include ActionController::Helpers
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from ApiExceptions::InvalidApiKey, with: :unauthorized
  helper_method :set_player

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
end
