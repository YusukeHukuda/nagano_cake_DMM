class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

  def show
    @order = Order.find(params[:id])
  end

  def update
   @order = Order.find(params[:id])
    @order_items = OrderItem.where(order_id: params[:id])
   if @order.update(order_params)
      @order_items.update_all(is_production: 1) if @order.is_order == "payment_confirmation"
   end
   redirect_to admin_order_path(@order)
  end

  private
  def order_params
    params.require(:order).permit(:is_order)
  end
end