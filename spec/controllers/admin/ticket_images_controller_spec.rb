# spec/controllers/admin/ticket_images_controller_spec.rb
require 'rails_helper' # 引入 RSpec 的测试辅助文件

RSpec.describe Admin::TicketImagesController, type: :controller do
  before do
    @admin_user = FactoryBot.create(:admin_user) # 假设使用 FactoryBot 并且有一个 :admin_user 工厂
    sign_in @admin_user
  end
  # 描述GET请求的#index动作
  describe 'GET #index' do
    it 'assigns @ticket_images' do
      # 它指定@ticket_images变量
      ticket = create(:ticket) # 创建一个ticket测试数据
      image = fixture_file_upload('image1.jpg')
      ticket_images = create_list(:ticket_image, 3, ticket: ticket, image: image) # 为这个ticket创建3个ticket_images测试数据
      get :index, params: { ticket_id: ticket.id } # 模拟发送GET请求到index动作，带上ticket_id参数
      expect(assigns(:ticket_images)).to match_array(ticket_images) # 期望@ticket_images包含刚才创建的ticket_images
    end
  end

  # 描述POST请求的#create动作
  describe 'POST #create' do
    it 'creates new ticket images' do
      # 它应该创建新的ticket images
      ticket = create(:ticket) # 创建一个ticket测试数据
      images = [
        fixture_file_upload('image1.jpg'),
        fixture_file_upload('image2.jpg')
      ] # 准备两个图片文件用于上传

      expect {
        post :create, params: { ticket_id: ticket.id, ticket_images: images }
      }.to change(TicketImage, :count).by(2) # 期望执行完POST请求后，TicketImage的数量增加了2
    end
  end

  # 描述DELETE请求的#destroy动作
  describe 'DELETE #destroy' do
    it 'destroys the requested ticket_image' do
      # 它应该删除指定的ticket_image
      ticket = create(:ticket) # 创建一个ticket测试数据
      image = fixture_file_upload('image1.jpg')
      ticket_image = create(:ticket_image, ticket: ticket, image: image) # 创建一个ticket_image测试数据

      expect {
        delete :destroy, params: { ticket_id: ticket.id, id: ticket_image.id }
      }.to change(TicketImage, :count).by(-1) # 期望执行完DELETE请求后，TicketImage的数量减少1
    end

    it 'redirects to the tickets list' do
      # 它应该重定向到tickets列表
      ticket = create(:ticket) # 创建一个ticket测试数据
      image = fixture_file_upload('image1.jpg')
      ticket_image = create(:ticket_image, ticket: ticket, image: image) # 创建一个ticket_image测试数据
      delete :destroy, params: { ticket_id: ticket.id, id: ticket_image.id } # 发送DELETE请求
      expect(response).to redirect_to(root_path) # 期望响应是重定向到root_path
    end
  end

  # 描述PATCH请求的#update动作
  describe 'PATCH #update' do
    it 'updates the requested ticket_image' do
      # 它应该更新指定的ticket_image
      ticket = create(:ticket) # 创建一个ticket测试数据
      image = fixture_file_upload('image1.jpg')
      ticket_image = create(:ticket_image, ticket: ticket, weight: 1,image: image) # 创建一个ticket_image测试数据，并设置weight为1
      patch :update, params: { ticket_id: ticket.id, id: ticket_image.id, weight: 2 } # 发送PATCH请求，修改weight为2
      ticket_image.reload # 重新加载ticket_image，以便获取最新的数据
      expect(ticket_image.weight).to eq(2) # 期望ticket_image的weight已经被更新为2
    end

    it 'redirects to the ticket_images list' do
      # 它应该重定向到ticket_images列表
      ticket = create(:ticket) # 创建一个ticket测试数据
      image = fixture_file_upload('image1.jpg')
      ticket_image = create(:ticket_image, ticket: ticket,image: image) # 创建一个ticket_image测试数据
      patch :update, params: { ticket_id: ticket.id, id: ticket_image.id, weight: 2 } # 发送PATCH请求
      expect(response).to redirect_to(root_path) # 期望响应是重定向到root_path
    end
  end
end
