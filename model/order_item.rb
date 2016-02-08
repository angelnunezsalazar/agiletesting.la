class OrderItem < ActiveRecord::Base
	belongs_to :product
	belongs_to :order

  def unit_price
    return product.price
  end

  def total_price
    return unit_price * quantity
  end
end