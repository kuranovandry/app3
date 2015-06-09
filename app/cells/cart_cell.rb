class CartCell < Cell::ViewModel
  include ActionView::Helpers::FormHelper
  include ActionView::Helpers::NumberHelper
  include Cell::Haml
  property :cart_items

  def show
    render
  end

  private

  def quantity
    cart_items.inject(0){|result, current| result + current.quantity}
  end

  def price
    cart_items.inject(0){|result, current| result + current.ticket.price}
  end
end
