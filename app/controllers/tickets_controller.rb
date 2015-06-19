class TicketsController < ApplicationController
  def show
    ticket = Ticket.find(params[:id])
    respond_to do |format|
      format.html
      format.pdf do
        pdf = BuyPdf.new(ticket)
        send_data pdf.render, type: 'application/pdf', disposition: 'inline'
      end
    end
  end

  def index
    movie = Movie.find params[:movie_id]
    @tickets = movie.tickets.order(:place_number)
  end

  def add_to_cart
    ticket = Ticket.find params[:id]
    current_user.add_to_cart(ticket, params)
    flash[:success] = t('cart_item.successful_create')
    redirect_to movies_path
  end
end
