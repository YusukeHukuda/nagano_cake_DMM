class Item < ApplicationRecord
  has_one_attached :image
  has_many :cart_item, dependent: :destroy
  has_many :order_item, dependent: :destroy
  belongs_to :genre


def with_tax_price
  (price * 1.1).floor
end

def subtotal
    item.with_tax_price * amount
end

  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end

end
