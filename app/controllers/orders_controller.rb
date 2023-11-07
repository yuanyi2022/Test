class OrdersController < ApplicationController

  def index
    @orders = Order.by_user_uuid(current_user.uuid)
    .order("id desc").includes([:ticket => [:main_ticket_image]])
  end

  def create
    stock_to_buy = params[:stock].to_i
    stock_to_buy = stock_to_buy <= 0 ? 1 : stock_to_buy
    @ticket = Ticket.find(params[:ticket_id])

    # 检查库存是否充足
    if @ticket.stock < stock_to_buy
      # 如果库存不足，可以渲染错误信息或者重定向
      render json: { error: "库存不足" }, status: :unprocessable_entity and return
    end
    # 减少库存数量
    @ticket.decrement!(:stock, stock_to_buy)

    # 检查库存是否为0，如果是，将状态设置为off
    if @ticket.stock == 0
      @ticket.update(status: 'off') # 假设 'off' 是用来表示不可用的状态
    end


    # 创建或更新订单
    @order = Order.create_or_update!({
      user_uuid: current_user.uuid,
      ticket_id: params[:ticket_id],
      stock: stock_to_buy
    })
    render layout: false
  end
  def update
    @order = Order.by_user_uuid(current_user.uuid)
    .where(id: params[:id]).first
    if @order
      stock = params[:stock].to_i
      stock = stock <= 0 ? 1 : stock

      @order.update_attribute :stock, stock
    end
    redirect_to orders_path
  end

  def destroy
    @order = Order.by_user_uuid(current_user.uuid)
    .where(id: params[:id]).first
    @order.destroy if @order

    redirect_to orders_path
  end
end
