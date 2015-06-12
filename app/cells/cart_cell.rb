class CartCell < Cell::ViewModel
  include ActionView::Helpers::FormHelper
  include ActionView::Helpers::NumberHelper
  include Cell::Haml
  property :quantity
  property :total_price

  def show
    render
  end
end
