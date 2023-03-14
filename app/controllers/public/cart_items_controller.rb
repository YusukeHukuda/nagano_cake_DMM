class Public::CartItemsController < ApplicationController
  
  def index
    @cart_items = current_customer.cart_items
    @total = 0
  end

  def update
    @cart_item = CartItem.find(params[:id])
    if @cart_item.update(cart_item_params)
      redirect_to public_cart_items_path, notice: "数量の変更を保存しました"
    else
      redirect_to request.referer, alert: "正しい数字を入力してください"
    end
    if @cart_item.amount == 0
      @cart_item.destroy
    end
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to public_cart_items_path, notice: "商品の削除に成功しました"
  end

  def destroy_all
    @cart_items = current_customer.cart_items
    @cart_items.destroy_all
    redirect_to public_cart_items_path, notice: "カート内を空にしました"
  end

  def create
    if current_customer.cart_items.find_by(item_id: prams[:cart_item][:item_id]).present?
      @cart_item.update(amount: @cart_item.amount + cart_item.amount)
    else
      @cart_item = CartItem.new(params_cart_item)
      @cart_item.save
    end
  end

  private
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end
end
