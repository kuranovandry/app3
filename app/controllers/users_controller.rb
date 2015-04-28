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

end
