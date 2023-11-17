require 'rails_helper'

RSpec.describe UserProfilesController, type: :controller do
  let(:user) { FactoryBot.create(:user) } # 使用FactoryBot创建用户实例
  before do
    sign_in user # 登录用户
  end

  describe 'GET #show' do
    it '成功响应并返回 HTTP 200 状态码' do
      get :show
      expect(response).to have_http_status(200)
    end

    it '分配当前用户给 @user 变量' do
      get :show
      expect(assigns(:user)).to eq(user)
    end

    it '渲染 show 模板' do
      get :show
      expect(response).to render_template(:show)
    end

    context '当没有用户登录时' do
      before do
        sign_out user # 登出用户
      end

      it '重定向到新用户会话路径' do
        get :show
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
