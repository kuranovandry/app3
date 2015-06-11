class UsersController < ApplicationController
  before_action :prepare_user, except: [:index, :new]

  def index
    @users = User.filter(params[:filter]).order('id').page(params[:page])
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

  def csv_mail
    @csv = User.to_csv_generator
    UserMailer.delay.csv_mail(@user, @csv)
    redirect_to users_path
  end

  private

  def user_params
    params.require(:user).permit(:first_name,
                                 :last_name,
                                 :date_of_birth,
                                 address_attributes: %i(id address city postal_code))
  end

  def prepare_user
    @user = User.find(params[:id])
  end
end
