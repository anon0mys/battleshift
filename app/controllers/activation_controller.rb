class ActivationController < ApplicationController
  def update
    user = User.find(params[:format])
    user.active!
    render :activated
  end
end
