# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  protected
  def after_sign_in_path_for(resource)
    if resource.role == 'admin'  # 或者 `resource.admin?`，取决于你如何定义 'admin' 角色
      admin_root_path  # 这应该是你的管理员仪表盘或主页的路径
    else
      super  # 这会调用 Devise 默认的重定向逻辑
    end
  end
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
