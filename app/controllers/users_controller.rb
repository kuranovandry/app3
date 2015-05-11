class UsersController < ApplicationController

  before_action :authenticate_user!
  before_action :get_user, except: [:index, :new]

  def index
    @users = User.order('email').page params[:page]
  end

  def update
    if @user.update(user_params)
      flash[:success] = t('user.successful_update')
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end

  def welcome
    UserMailer.delay.welcome(@user)
    redirect_to users_path
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :date_of_birth, address_attributes: [ :id, :address, :city, :postal_code ])
  end

  def get_user
    @user = User.find(params[:id])
  end

end
