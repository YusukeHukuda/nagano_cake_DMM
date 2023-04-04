class CreateOrderItems < ActiveRecord::Migration[6.1]
  def change
    create_table :order_items do |t|
      t.integer :order_id
      t.integer :item_id
      t.integer :price_tax
      t.integer :amount
      t.integer :is_production, null: false, default: 0

      t.timestamps
    end
  end
end
