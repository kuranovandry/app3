class ApplicationDecorator < Draper::Decorator
  include Draper::LazyHelpers

  delegate_all

  def error_message(field)
    return unless object.errors[field].any? content_tag(:div, object.errors.full_messages_for(field).join(', '),
                                                        class: 'field_with_errors')
  end
end
