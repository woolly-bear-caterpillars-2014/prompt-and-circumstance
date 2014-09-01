module SessionsHelper
  def display_session_links
    if current_user.present?
      render 'partials/logout'
    else
      render 'partials/login_links'
    end
  end

  #def current_user
    #@user ||= User.find(session[:user_id])
  #end
end
