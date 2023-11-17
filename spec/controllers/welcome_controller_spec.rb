require 'rails_helper'

RSpec.describe WelcomeController, type: :controller do

  describe 'GET #index' do
  before do
    # 创建两个虚拟的 Ticket 记录
    @ticket1 = FactoryBot.create(:ticket)
    @ticket2 = FactoryBot.create(:ticket)
  end
    it '成功响应并返回 HTTP 200 状态码' do
      get :index
      expect(response).to have_http_status(200)
    end
    it '分配 @tickets 实例变量' do
      get :index
      expect(assigns(:tickets)).to be_an(ActiveRecord::Relation)
    end
    it '渲染 index 模板' do
      get :index
      expect(response).to render_template(:index)
    end

    it '检查 @tickets 是否包括主要票务图片信息' do
      get :index
      expect(assigns(:tickets).includes_values).to include(:main_ticket_image)
    end

    it '默认分页为1页，每页12个条目' do
      get :index
      expect(assigns(:tickets).current_page).to eq(1)
      expect(assigns(:tickets).limit_value).to eq(12)
    end

    it '按id降序排序' do
      get :index
      expect(assigns(:tickets).order_values).to eq(["id desc"])
    end

    context '当未登录用户访问时' do
      let(:user) { FactoryBot.create(:user) } # 使用FactoryBot创建用户实例
      before do
        sign_out user
      end

      it '不需要身份验证' do
        get :index
        expect(response).to have_http_status(200) # 或其他期望的状态码
      end
    end
  end
end
