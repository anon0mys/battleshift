class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = 'Registration successful'
      session[:user_id] = @user.id
      RegistrationMailer.confirmation_email(@user).deliver_now
      redirect_to dashboard_path
    else
      flash[:error] = 'Registration unsuccessful'
      redirect_to register_path
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
