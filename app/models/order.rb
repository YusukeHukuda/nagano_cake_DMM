class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_item, dependent: :destroy
  
  enum payment_method: { credit_card: 0, transfer: 1 }
  enum status: { 入金待ち: 0, 入金確認: 1, 製作中: 2, 配送準備中: 3, 配送済み: 4}
  
  
  def order_details_total(order)
    array = []
    order.order_detail.each do |order_detail|
      array << order_detail.amount
    end
    array.sum
  end
end
