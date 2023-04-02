class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :item

  enum is_production: { not_startable: 0, waiting_for_production: 1, in_production: 2,  production_completed: 3}
end
