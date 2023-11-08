require 'rails_helper' # 引入 RSpec 的测试辅助文件
RSpec.describe Users::SessionsController, type: :controller do
  let(:user) { create(:admin_user) }
  before do
    sign_in user
  end
  # def after_sign_in_path_for(resource)
  #   if resource.role == 'admin'  # 或者 `resource.admin?`，取决于你如何定义 'admin' 角色
  #     admin_root_path  # 这应该是你的管理员仪表盘或主页的路径
  #   else
  #     super  # 这会调用 Devise 默认的重定向逻辑
  #   end
  # end
  describe 'GET #new' do
    it 'should redirect to admin root path' do
      get :new
      expect(response).to redirect_to(admin_root_path)
    end
  end
end