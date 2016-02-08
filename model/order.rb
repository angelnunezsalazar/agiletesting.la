class Order < ActiveRecord::Base
	has_many :order_items
	belongs_to :shipping_detail

	after_initialize :init

	def init
	    self.state ||="Pending"
	    self.shipping_cost ||=0
	    self.subtotal_items ||=0
	    self.discount ||=0
	    self.total ||=0
	end

	def add_product(product_id,quantity)
		order_item=order_items.detect  {|oi| oi.product_id==product_id}
		if order_item.nil?
			order_item=OrderItem.new(:product_id=>product_id,:quantity=>quantity)
			self.order_items<<order_item
		
		else
			order_item.quantity=order_item.quantity+1
		end

		recalculate_subtotal_items
		recalculate_total
	end

	def remove_item(order_item_id)
		order_item=order_items.detect  {|oi| oi.id==order_item_id}
		self.order_items.delete(order_item)
		recalculate_subtotal_items
		recalculate_total
	end

	def items_count
		order_items.count
	end

	def products_count
		order_items.collect { |oi| oi.quantity}.sum
	end

	def add_shipping(shipping_detail,shipping_cost)
		self.shipping_detail=shipping_detail
		self.shipping_cost=shipping_cost
		recalculate_total
	end

	def apply_discount(discount)
		self.discount=discount
		recalculate_total
	end

	def place_order
		self.state="Confirmed"
	end

	def recalculate_subtotal_items
		self.subtotal_items=order_items.collect { |oi| oi.total_price}.sum
	end

	def recalculate_total
		self.total=self.subtotal_items + self.shipping_cost - self.discount
		if self.total<0
			self.total=0
		end
	end
end