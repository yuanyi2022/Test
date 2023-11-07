class UserProfilesController < ApplicationController
  def show
    @user = current_user
    redirect_to new_user_session_path unless @user
  end
end
