class ActivationController < ApplicationController
  def update
    user = User.find(params[:id])
    if status_params[:token]
      user.update(status: 'active')
      redirect_to activation_path(user)
    else
      render file: "#{Rails.root}/public/404.html", status: 404
    end
  end

  def show
  end

  private

  def status_params
    params.require(:authentication).permit(:token)
  end
end
