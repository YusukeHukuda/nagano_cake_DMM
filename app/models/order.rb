class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_item, dependent: :destroy

  enum payment_method: { credit_card: 0, transfer: 1 }
  enum is_order: { waiting_for_deposit: 0, payment_confirmation: 1, in_production: 2, ready_to_ship: 3, sent: 4}


  def order_details_total(order)
    array = []
    order.order_item.each do |order_item|
      array << order_item.amount
    end
    array.sum
  end
end
