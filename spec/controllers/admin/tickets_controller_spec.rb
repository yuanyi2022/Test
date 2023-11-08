# spec/controllers/admin/ticket_images_controller_spec.rb
require 'rails_helper' # 引入 RSpec 的测试辅助文件

RSpec.describe Admin::TicketsController, type: :controller do
  before do
    @admin_user = FactoryBot.create(:admin_user) # 假设使用 FactoryBot 并且有一个 :admin_user 工厂
    sign_in @admin_user
  end
  # 描述GET请求的#index动作
  describe 'GET #index' do
    it 'assigns @tickets' do
      ticket = create(:ticket) # 创建一个ticket测试数据
      get :index # 模拟发送GET请求到index动作
      expect(assigns(:tickets)).to match_array([ticket]) # 期望@tickets包含刚才创建的ticket
    end
  end

  # 描述POST请求的#create动作
  describe 'POST #create' do
    it'creates new ticket' do
      expect {
        post :create, params: { ticket: attributes_for(:ticket) }
      }.to change(Ticket, :count).by(1) # 期望执行完POST请求后，Ticket的数量增加了1
    end
  end
  #edit
  describe 'GET #edit' do
    it 'assigns @ticket' do
      ticket = create(:ticket) # 创建一个ticket测试数据
      get :edit, params: { id: ticket.id } # 模拟发送GET请求到edit动作，带上id参数
      expect(assigns(:ticket)).to eq(ticket) # 期望@ticket等于刚才创建的ticket
    end
  end

  # 描述DELETE请求的#destroy动作
  describe 'DELETE #destroy' do
    it 'should delete ticket' do
      ticket = create(:ticket) # 创建一个ticket测试数据
      expect {
        delete :destroy, params: { id: ticket.id }
      }.to change(Ticket, :count).by(-1) # 期望执行完DELETE请求后，Ticket的数量减少1
    end

  end

  # 描述PATCH请求的#update动作
  # create_table "tickets", force: :cascade do |t|
  #     t.string "movie_name"
  #     t.datetime "show_time"
  #     t.integer "duration"
  #     t.integer "stock"
  #     t.integer "price"
  #     t.string "status"
  #     t.string "uuid"
  #     t.text "description"
  #     t.datetime "created_at", null: false
  #     t.datetime "updated_at", null: false
  #   end
  describe 'PATCH #update' do
    it 'should update movie_name' do
      ticket = create(:ticket) # 创建一个ticket测试数据
      patch :update, params: { id: ticket.id, ticket: { movie_name: 'New Movie Name' } } # 发送PATCH请求
      expect(ticket.reload.movie_name).to eq('New Movie Name') # 期望ticket的movie_name属性已经被更新
    end
    #YYYY-MM-DD HH:MM:SS
    let(:time) { Time.now.strftime('%Y-%m-%d %H:%M:%S') }
    it 'should update show_time' do
      ticket = create(:ticket) # 创建一个ticket测试数据
      patch :update, params: { id: ticket.id, ticket: { show_time: time } } # 发送PATCH请求
      expect(ticket.reload.show_time).to eq(time) # 期望ticket的show_time属性已经被更新
    end
    it 'should update duration' do
      ticket = create(:ticket) # 创建一个ticket测试数据
      patch :update, params: { id: ticket.id, ticket: { duration: 120 } } # 发送PATCH请求
      expect(ticket.reload.duration).to eq(120) # 期望ticket的duration属性已经被更新
    end
    it 'should update stock' do
      ticket = create(:ticket) # 创建一个ticket测试数据
      patch :update, params: { id: ticket.id, ticket: { stock: 100 } } # 发送PATCH请求
      expect(ticket.reload.stock).to eq(100) # 期望ticket的stock属性已经被更新
    end
    it 'should update price' do
      ticket = create(:ticket) # 创建一个ticket测试数据
      patch :update, params: { id: ticket.id, ticket: { price: 100 } } # 发送PATCH请求
      expect(ticket.reload.price).to eq(100) # 期望ticket的price属性已经被更新
    end
    it 'should update status' do
      ticket = create(:ticket) # 创建一个ticket测试数据
      patch :update, params: { id: ticket.id, ticket: { status: 'off' } } # 发送PATCH请求
      expect(ticket.reload.status).to eq('off') # 期望ticket的status属性已经被更新
    end
    it 'should update description' do
      ticket = create(:ticket) # 创建一个ticket测试数据
      patch :update, params: { id: ticket.id, ticket: { description: 'New Description' } } # 发送PATCH请求
      expect(ticket.reload.description).to eq('New Description') # 期望ticket的description属性已经被更新
    end
  end
end
