require 'rails_helper'

module RequestHelpers
  def create_logged_in_user
    user = create(:user)
    login(user)
    user
  end

  def login(user)
    login_as user, scope: :user
  end

  def with_confirm(accept = true)
    page.evaluate_script 'window.original_confirm_function = window.confirm'
    page.evaluate_script "window.confirm = function(msg) { return #{!!accept}; }"
    yield
  ensure
    page.evaluate_script 'window.confirm = window.original_confirm_function'
  end
end
