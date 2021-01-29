module ApplicationHelper
  def render_login
    if user_signed_in?
      'Logged in with ' + current_user.email
    else
      'No Login'
    end
  end

  def render_logout
    if user_signed_in?
      link_to 'Logout', destroy_user_session_path, method: :delete
    else
      ' '
    end
  end
end
