require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  let(:user) { create(:user) } # 如果你使用了用户身份验证，创建一个用户
  let(:ticket) { create(:ticket) } # 创建一个票，库存为10

  before do
    sign_in(user) # 使用适当的身份验证方法登录用户
  end

  describe 'GET #index' do
    it 'assigns @orders' do
      order = create(:order, user_uuid: user.uuid, ticket: ticket)
      get :index
      expect(assigns(:orders)).to include(order)
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template('index')
    end
  end

  describe 'POST #create' do
    it 'creates a new order' do
      post :create, params: { ticket_id: ticket.id, stock: 3 }
      expect(Order.count).to eq(1)
      expect(Order.first.user_uuid).to eq(user.uuid)
    end

    it 'decrements the ticket stock' do
      expect { post :create, params: { ticket_id: ticket.id, stock: 3 } }.to change { ticket.reload.stock }.by(-3)
    end

    it 'sets ticket status to "off" when stock reaches 0' do
      post :create, params: { ticket_id: ticket.id, stock: 10 }
      expect(ticket.reload.status).to eq('off')
    end

    it 'renders JSON error message if stock is insufficient' do
      post :create, params: { ticket_id: ticket.id, stock: 20 }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body)['error']).to eq('库存不足')
    end
  end

  describe 'PATCH #update' do
    it 'updates the order stock' do
      order = create(:order, user_uuid: user.uuid, ticket: ticket)
      patch :update, params: { id: order.id, stock: 5 }
      expect(order.reload.stock).to eq(5)
    end

    it 'redirects to the orders index page' do
      order = create(:order, user_uuid: user.uuid, ticket: ticket)
      patch :update, params: { id: order.id, stock: 5 }
      expect(response).to redirect_to(orders_path)
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the order' do
      order = create(:order, user_uuid: user.uuid, ticket: ticket)
      delete :destroy, params: { id: order.id }
      expect(Order.count).to eq(0)
    end

    it 'redirects to the orders index page' do
      order = create(:order, user_uuid: user.uuid, ticket: ticket)
      delete :destroy, params: { id: order.id }
      expect(response).to redirect_to(orders_path)
    end
  end
end
