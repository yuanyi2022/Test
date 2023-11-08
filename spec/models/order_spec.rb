require 'rails_helper'

RSpec.describe Order, type: :model do
  let(:ticket) { create(:ticket) }
  let(:user_uuid) { SecureRandom.uuid }
  let(:ticket_id) { ticket.id }
  let(:stock) { 10 }
  describe 'validations' do
    it 'is valid with a user_uuid, ticket_id, and stock' do
      order = build(:order, user_uuid: user_uuid, ticket: ticket, stock: 5)
      expect(order).to be_valid
    end
    it 'is not valid without a user_uuid' do
      order = build(:order, user_uuid: nil, ticket: ticket, stock: 5)
      expect(order).not_to be_valid
    end
    it 'is not valid without a ticket_id' do
      order = build(:order, user_uuid: user_uuid, ticket: nil, stock: 5)
      expect(order).not_to be_valid
    end
    it 'is not valid without stock' do
      order = build(:order, user_uuid: user_uuid, ticket: ticket, stock: nil)
      expect(order).not_to be_valid
    end
  end
  describe '.create_or_update!' do
    context 'when no existing order' do
      it 'creates a new order' do
        expect {
          Order.create_or_update!(user_uuid: user_uuid, ticket_id: ticket.id, stock: 10)
        }.to change(Order, :count).by(1)
      end
    end
    context 'when an existing order is present' do
      let!(:existing_order) { create(:order, user_uuid: user_uuid, ticket: ticket, stock: 10) }
      it 'does not create a new order' do
        expect {
          Order.create_or_update!(user_uuid: user_uuid, ticket_id: ticket.id, stock: 5)
        }.not_to change(Order, :count)
      end
      it 'updates the stock of the existing order' do
        updated_order = Order.create_or_update!(user_uuid: user_uuid, ticket_id: ticket.id, stock: 5)
        expect(updated_order.stock).to eq(existing_order.stock + 5)
      end
    end
  end
  describe 'scopes' do
    let!(:order1) { create(:order, user_uuid: user_uuid, ticket: ticket, stock: 10) }
    let!(:order2) { create(:order, user_uuid: SecureRandom.uuid, ticket: ticket, stock: 15) }
    it 'returns orders with the specific user_uuid' do
      expect(Order.by_user_uuid(user_uuid)).to include(order1)
      expect(Order.by_user_uuid(user_uuid)).not_to include(order2)
    end
  end
end