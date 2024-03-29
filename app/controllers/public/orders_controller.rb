class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    unless current_customer.cart_items.present?
      redirect_to root_path, alert: "予期せぬエラーが発生しました"
    end
  end

  def confirmation
    @order = Order.new(order_params)
    if params[:order][:address_option] == "0"
      @order.name = current_customer.last_name + current_customer.first_name
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address

    elsif params[:order][:address_option] == "1"
      ship = Address.find(params[:order][:address_id])
      @order.address = ship.address
      @order.postal_code = ship.postal_code
      @order.name = ship.name

    elsif params[:order][:address_option] == "2"
      @order.address = params[:order][:address]
      @order.name = params[:order][:name]
      @order.postal_code = params[:order][:postal_code]

    else
      render :new
    end

    @cart_items = current_customer.cart_items.all
    @order.postage = 800
    # @total_payment =
    @cart_items.each do |cart_item|
      @total_payment = cart_item.item.with_tax_price * cart_item.amount
    end
    @order.payment = @total_payment
    @order.customer_id = current_customer.id
  end

  def thanks
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.save

    current_customer.cart_items.each do |cart_item|
      @order_items = OrderItem.new
      @order_items.item_id = cart_item.item_id
      @order_items.amount = cart_item.amount
      @order_items.price_tax = cart_item.item.with_tax_price
      @order_items.order_id = @order.id
      @order_items.save
    end

    current_customer.cart_items.destroy_all
    redirect_to thanks_path, notice: "注文が完了しました"
  end

  def index
    @orders = current_customer.orders.all
  end

  def show
      @order = Order.find(params[:id])
      @order.postage = 800
  end

  private
  def order_params
    params.require(:order).permit(:payment_method, :postal_code, :name, :address, :customer_id, :is_order, :payment, :postage)
  end
end