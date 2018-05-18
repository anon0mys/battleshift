class ApiController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from ApiExceptions::InvalidApiKey, with: :unauthorized

  def not_found
    render file: "#{Rails.root}/public/404.html", status: 400
  end

  def unauthorized(exception)
    render json: { message: exception.message }, status: 401
  end
end
