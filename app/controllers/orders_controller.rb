class OrdersController < ApplicationController
  def index
    @orders = Order.by_user_uuid(session[:user_uuid])
    .order("id desc").includes([:ticket => [:main_ticket_image]])
  end

  def create
    stock = params[:stock].to_i
    stock = stock <= 0 ? 1 : stock
    @ticket = Ticket.find(params[:ticket_id])
    @order = Order.create_or_update!({
      user_uuid: session[:user_uuid],
      ticket_id: params[:ticket_id],
      stock: stock
    })
    render layout: false
  end
  def update
    @order = Order.by_user_uuid(session[:user_uuid])
    .where(id: params[:id]).first
    if @order
      stock = params[:stock].to_i
      stock = stock <= 0 ? 1 : stock

      @order.update_attribute :stock, stock
    end
    redirect_to orders_path
  end

  def destroy
    @order = Order.by_user_uuid(session[:user_uuid])
    .where(id: params[:id]).first
    @order.destroy if @order

    redirect_to orders_path
  end
end
