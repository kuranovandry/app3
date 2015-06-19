module CartHelper
  def show_cart?(cart)
    cart.nil? || cart.cart_items.empty?
  end
end
