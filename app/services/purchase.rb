class Purchase
  #-----------Class methods------------
  def self.move_from_cart_to_order(current_user)
    cart = current_user.cart
    order = current_user.orders.create
    ActiveRecord::Base.transaction do
      cart.cart_items.find_each do |item|
        transaction = current_user.transfer_money(item.ticket.owner_id, item.ticket.price)
        order.order_items.create(order: order, price: item.ticket.price, ticket: item.ticket, transaction_id: transaction.id)
        item.destroy
      end
    end
  end
end
