class ApplicationController < ActionController::Base
  before_action :set_browser_uuid
  def set_browser_uuid
    uuid = cookies[:user_uuid]
    unless uuid
      if user_signed_in?
        uuid = current_user.user_uuid
      else
        redirect_to new_user_session_path
      end
    end
    update_browser_uuid uuid
  end

  def update_browser_uuid uuid
    session[:user_uuid] = cookies.permanent['user_uuid'] = uuid
  end
end
