class OrdersController < ApplicationController
  def create
    if current_user.can_afford?
      current_user.purchase_cart
      flash[:success] = t('order.successful_purchase')
    else
      flash[:error] = t('order.purchase_error')
    end
    redirect_to cart_path
  end
end
