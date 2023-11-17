require 'rails_helper'

RSpec.feature 'Order', type: :feature do
  let(:user) { create(:user) }
  let(:ticket) { create(:ticket) } # 创建一个票，库存为10

  before do
    sign_in user # 使用适当的身份验证方法登录用户
  end

  scenario 'User creates a new order' do
    visit root_path # 假设这是你的首页，用来选择票
    click_button '购买' # 点击创建订单按钮

    # 期望页面上显示订单成功创建的消息
    expect(page).to have_content('创建订单成功')

    # 期望订单数量已经增加了
    expect(Order.count).to eq(1)

    # 期望库存数量已经减少了
    expect(ticket.reload.stock).to eq(7)
  end

  scenario 'User updates an order' do
    # 创建一个订单，假设有一个页面显示用户的订单
    order = create(:order, user_uuid: user.uuid, ticket: ticket, stock: 5)

    visit user_orders_path(user) # 假设这是显示用户订单的页面

    # 假设页面上有一个链接或按钮用于更新订单
    click_link 'Edit'

    # 假设有一个表单用于更新订单的库存
    fill_in '库存', with: 7 # 输入新的库存数量
    click_button 'Update Order' # 点击更新订单按钮

    # 期望页面上显示订单更新成功的消息
    expect(page).to have_content('Order was successfully updated.')

    # 期望订单的库存已经更新
    expect(order.reload.stock).to eq(7)
  end

  scenario 'User deletes an order' do
    # 创建一个订单，假设有一个页面显示用户的订单
    order = create(:order, user_uuid: user.uuid, ticket: ticket)

    visit user_orders_path(user) # 假设这是显示用户订单的页面

    # 假设页面上有一个链接或按钮用于删除订单
    click_link 'Destroy'

    # 期望页面上显示订单删除成功的消息
    expect(page).to have_content('Order was successfully destroyed.')

    # 期望订单已被删除
    expect(Order.count).to eq(0)
  end
end
