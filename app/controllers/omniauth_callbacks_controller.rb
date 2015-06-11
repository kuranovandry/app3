class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def linkedin
    @user = User.connections(request.env['omniauth.auth'], current_user)
    if @user.persisted?
      sign_in_method
    else
      session['devise.linkedin_uid'] = request.env['omniauth.auth']
      redirect_to new_user_registration_url
    end
  end

  def facebook
    @user = User.connections(request.env['omniauth.auth'], current_user)
    if @user.persisted?
      sign_in_method
    else
      session['devise.facebook_data'] = request.env['omniauth.auth']
      redirect_to new_user_registration_url
    end
  end

  def sign_in_method
    sign_in_and_redirect @user, event: :authentication
    set_flash_message(:notice, :success, kind: @user.provider.capitalize) if is_navigational_format?
  end
end
