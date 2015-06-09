class BuyPdf < Prawn::Document
  include ActionView::Helpers::SanitizeHelper

  def initialize(ticket)
    super(top_margin: 20, page_size: 'C6')
    @ticket = ticket
    ticket_top
    ticket_table
  end

  def ticket_top
    text "Ticket on #{@ticket.name}", size: 30, style: :bold, align: :center
  end

  def ticket_table
    move_down 20
    table line_item_rows do
      row(0).font_style = :bold
      columns(1..2).align = :right
      self.row_colors = %w(DDDDDD FFFFFF)
      self.header = true
    end
  end

  def line_item_rows
    [['Movie name', 'Place number', 'Price']] +
      [[@ticket.name, @ticket.place_number, @ticket.price]]
  end
end
