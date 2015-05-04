module ApplicationHelper
  def error_message(resource, field)
    if resource.errors[field].any?
      content_tag(:div, resource.errors.full_messages_for(field).join(', '), class: 'field_with_errors')
    end
  end

  def owner(project)
    current_user.id == project.user_id
  end
end
