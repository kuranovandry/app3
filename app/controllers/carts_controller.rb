class CartsController < ApplicationController
  def show
    @cart = current_user.cart
  end

  def destroy
    if current_user.cart.destroy
      flash[:success] = t('cart.successful_destroy')
    else
      flash[:error] = t('cart.error_destroy')
    end
    redirect_to root_path
  end
end
