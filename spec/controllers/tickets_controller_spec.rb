require 'rails_helper'

RSpec.describe TicketsController, type: :controller do
  let(:user) { FactoryBot.create(:user) } # 使用FactoryBot创建用户实例
  let(:ticket) { FactoryBot.create(:ticket) } # 创建票，不关联用户
  before do
    sign_in user # 登录用户
  end
  describe 'GET #show' do
    before do
      get :show, params: { id: ticket.id }
    end
    it 'assigns the requested ticket to @ticket' do
      expect(assigns(:ticket)).to eq(ticket)
    end
    it 'renders the :show template' do
      expect(response).to render_template(:show)
    end
  end
  describe 'GET #search' do
    let!(:ticket_on) { FactoryBot.create(:ticket, movie_name: 'Star Wars', status: 'on') }
    let!(:ticket_off) { FactoryBot.create(:ticket, movie_name: 'Star Trek', status: 'off') }
    before do
      get :search, params: { w: 'Star' }
    end
    it 'populates an array of tickets with status on' do
      expect(assigns(:tickets)).to include(ticket_on)
      expect(assigns(:tickets)).not_to include(ticket_off)
    end
    it 'renders the welcome/index template' do
      expect(response).to render_template('welcome/index')
    end
  end
end
