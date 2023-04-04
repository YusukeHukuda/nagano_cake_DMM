class Admin::OrderItemsController < ApplicationController
  def update

    @order = Order.find(params[:order_id])
    @order_item = OrderItem.find(params[:id])
    @order_items = @order.order_item.all

    is_updated = true
    if @order_item.update(order_item_params)
      @order.update(is_order: 2) if @order_item.is_production == "in_production"
      @order_items.each do |order_item|
        if order_item.is_production != "production_completed"
          is_updated = false
        end
      end
      @order.update(is_order: 3) if is_updated
    end
    redirect_to admin_order_path(@order)
  end

  private

  def order_item_params
    params.require(:order_item).permit(:is_production)
  end
end
