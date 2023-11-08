require 'rails_helper' # 引入 RSpec 的测试辅助文件
RSpec.describe OrdersController, type: :controller do

  # 描述GET请求的#index动作
  # def index
  #     @orders = Order.by_user_uuid(current_user.uuid)
  #     .order("id desc").includes([:ticket => [:main_ticket_image]])
  #   end
  #
  #   def create
  #     stock_to_buy = params[:stock].to_i
  #     stock_to_buy = stock_to_buy <= 0 ? 1 : stock_to_buy
  #     @ticket = Ticket.find(params[:ticket_id])
  #
  #     # 检查库存是否充足
  #     if @ticket.stock < stock_to_buy
  #       # 如果库存不足，可以渲染错误信息或者重定向
  #       render json: { error: "库存不足" }, status: :unprocessable_entity and return
  #     end
  #     # 减少库存数量
  #     @ticket.decrement!(:stock, stock_to_buy)
  #
  #     # 检查库存是否为0，如果是，将状态设置为off
  #     if @ticket.stock == 0
  #       @ticket.update(status: 'off') # 假设 'off' 是用来表示不可用的状态
  #     end
  #
  #
  #     # 创建或更新订单
  #     @order = Order.create_or_update!({
  #       user_uuid: current_user.uuid,
  #       ticket_id: params[:ticket_id],
  #       stock: stock_to_buy
  #     })
  #     render layout: false
  #   end
  #   def update
  #     @order = Order.by_user_uuid(current_user.uuid)
  #     .where(id: params[:id]).first
  #     if @order
  #       stock = params[:stock].to_i
  #       stock = stock <= 0 ? 1 : stock
  #
  #       @order.update_attribute :stock, stock
  #     end
  #     redirect_to orders_path
  #   end
  #
  #   def destroy
  #     @order = Order.by_user_uuid(current_user.uuid)
  #     .where(id: params[:id]).first
  #     @order.destroy if @order
  #
  #     redirect_to orders_path
  #   end
  describe 'GET #index' do
    it 'assigns @orders' do
      order = create(:order) # 创建一个order测试数据
      get :index # 模拟发送GET请求到index动作
      expect(assigns(:orders)).to match_array([order]) # 期望@orders包含刚才创建的order
    end
  end
  describe 'POST #create' do
    it 'creates new order' do
      ticket = create(:ticket) # 创建一个ticket测试数据
      post :create, params: { ticket_id: ticket.id, stock: 1 } # 发送POST请求
      expect(Order.count).to eq(1) # 期望Order的数量为1
    end
  end
  describe 'PATCH #update' do
    it 'should update stock' do
      order = create(:order) # 创建一个order测试数据
      patch :update, params: { id: order.id, stock: 2 } # 发送PATCH请求
      expect(order.reload.stock).to eq(2) # 期望order的stock属性已经被更新
    end
  end
  describe 'DELETE #destroy' do
    it 'should delete order' do
      order = create(:order) # 创建一个order测试数据
      expect {
        delete :destroy, params: { id: order.id }
      }.to change(Order, :count).by(-1) # 期望执行完DELETE请求后，Order的数量减少1
    end
  end
end