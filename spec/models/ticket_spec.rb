require 'rails_helper'

RSpec.describe Ticket, type: :model do
  let(:valid_attributes) {
    {
      movie_name: 'Inception',
      show_time: DateTime.now + 3.days, # 设定一个未来的放映时间
      duration: 120,
      stock: 100,
      price: 50.0,
      status: 'on',
      description: 'A mind-bending sci-fi thriller.'
    }
  }
  it 'is valid with valid attributes' do
    ticket = Ticket.new(valid_attributes)
    expect(ticket).to be_valid
  end
  it 'is not valid without a movie name' do
    ticket = Ticket.new(valid_attributes.except(:movie_name))
    expect(ticket).to_not be_valid
    expect(ticket.errors[:movie_name]).to include("电影名称不能为空")
  end
  it 'is not valid without a show time' do
    ticket = Ticket.new(valid_attributes.except(:show_time))
    expect(ticket).to_not be_valid
    expect(ticket.errors[:show_time]).to include("放映时间不能为空")
  end
  it 'is not valid without a duration' do
    ticket = Ticket.new(valid_attributes.except(:duration))
    expect(ticket).to_not be_valid
    expect(ticket.errors[:duration]).to include("时长不能为空")
  end
  it 'is not valid without stock' do
    ticket = Ticket.new(valid_attributes.except(:stock))
    expect(ticket).to_not be_valid
    expect(ticket.errors[:stock]).to include("库存不能为空")
  end
  it 'is not valid with non-integer stock' do
    ticket = Ticket.new(valid_attributes.merge(stock: 'ten'))
    expect(ticket).to_not be_valid
    expect(ticket.errors[:stock]).to include("库存必须是整数")
  end
  it 'is not valid without a price' do
    ticket = Ticket.new(valid_attributes.except(:price))
    expect(ticket).to_not be_valid
    expect(ticket.errors[:price]).to include("价格不能为空")
  end
  it 'is not valid with non-numeric price' do
    ticket = Ticket.new(valid_attributes.merge(price: 'ten'))
    expect(ticket).to_not be_valid
    expect(ticket.errors[:price]).to include("价格必须是数字")
  end
  it 'is not valid without a status' do
    ticket = Ticket.new(valid_attributes.except(:status))
    expect(ticket).to_not be_valid
    expect(ticket.errors[:status]).to include("状态不能为空")
  end
  it 'is not valid with an invalid status' do
    ticket = Ticket.new(valid_attributes.merge(status: 'invalid_status'))
    expect(ticket).to_not be_valid
    expect(ticket.errors[:status]).to include("状态必须是上架或下架")
  end
  it 'is not valid without a description' do
    ticket = Ticket.new(valid_attributes.except(:description))
    expect(ticket).to_not be_valid
    expect(ticket.errors[:description]).to include("描述不能为空")
  end
  it 'should have a uuid after creation' do
    ticket = Ticket.create!(valid_attributes)
    expect(ticket.uuid).not_to be_nil
  end
  describe 'scopes' do
    before do
      @ticket1 = Ticket.create!(valid_attributes.merge(status: 'on'))
      @ticket2 = Ticket.create!(valid_attributes.merge(status: 'off'))
    end
    it 'returns the tickets with status on' do
      expect(Ticket.onshelf).to include(@ticket1)
      expect(Ticket.onshelf).to_not include(@ticket2)
    end
  end
end