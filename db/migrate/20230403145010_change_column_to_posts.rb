class ChangeColumnToPosts < ActiveRecord::Migration[6.1]
  def change
      change_column_default(:order_items, :is_production, from: nil, to: "0")
  end
end
