class BuyPdf < Prawn::Document
  include ActionView::Helpers::SanitizeHelper

  def initialize(movie)
    super(top_margin: 20, page_size: 'C6')
    @movie = movie
    movie_top
    movie_table
  end

  def remove_html(string)
    sanitize(string, tags: {})
  end

  def movie_top
    text "Ticket on #{@movie.name}", size: 30, style: :bold, align: :center
  end

  def movie_table
    move_down 20
    table line_item_rows do
      row(0).font_style = :bold
      columns(1..2).align = :right
      self.row_colors = %w(DDDDDD FFFFFF)
      self.header = true
    end
  end

  def line_item_rows
    [["Name", "Description"]] +
      [[@movie.name, remove_html(@movie.description)]]
  end
end
