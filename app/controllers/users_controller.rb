class UsersController < ApplicationController

  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def welcome
    user = User.find(params[:id])
    UserMailer.delay.welcome(user)
    redirect_to users_path
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :date_of_birth)
  end

end
