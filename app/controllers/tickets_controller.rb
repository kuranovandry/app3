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
end
