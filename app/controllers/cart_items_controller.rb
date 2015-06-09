class CartItemsController < ApplicationController
  def destroy
    cart = current_user.cart
    cart_item = cart.cart_items.find params[:id]
    if cart_item.destroy
      flash[:success] = t('cart_item.successful_destroy')
    else
      flash[:error] = t('cart_item.error_destroy')
    end
    redirect_to cart_path
  end
end
