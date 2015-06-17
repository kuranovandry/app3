class MovieDecorator < ApplicationDecorator
  def owner(current_user)
    object.user_id == current_user.id
  end

  def format_date
    object.release_date.strftime('%m/%d/%Y') if object.release_date
  end
end
