class ChangeColumnToPosts2 < ActiveRecord::Migration[6.1]
  def change
    change_column_default(:orders, :is_order, from: nil, to: "0")
  end
end
