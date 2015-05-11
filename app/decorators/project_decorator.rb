class ProjectDecorator < ApplicationDecorator
  def owner(current_user)
    object.user_id == current_user.id
  end
end
