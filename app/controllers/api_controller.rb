class ApiController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def not_found
    render file: "#{Rails.root}/public/404.html", status: 400
  end
end
