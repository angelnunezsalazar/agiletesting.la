class CreateProducts < ActiveRecord::Migration
	def change
		create_table "products", :force => true do |t|
		    t.string  "name"
		    t.string  "description"
		    t.decimal "price",       precision: 8, scale: 2
		    t.string  "img"
	  	end

	  	create_table "product_reviews", :force => true do |t|
		    t.string	"reviewer"
		    t.string	"comment"
		    t.integer 	"rating"
		    t.datetime	"review_date"
		    t.integer 	"product_id"
	  	end

		create_table "order_items", :force => true do |t|
		    t.integer "order_id"
		    t.integer "product_id"
		    t.integer "quantity"
		end

		create_table "delivery_options", :force => true do |t|
		    t.string "name"
		    t.integer "min_days"
		    t.integer "max_days"
		    t.boolean "default_active", default: false
		    t.boolean "business_day"
		end

		create_table "shipping_details", :force => true do |t|
		    t.string "full_name"
		    t.string "address_line"
		    t.string "city"
		    t.string "country"
		    t.integer "delivery_option_id"
		end

		create_table "orders", :force => true do |t|
		    t.decimal "total", precision: 8, scale: 2
		    t.decimal "subtotal_items", precision: 8, scale: 2
		    t.decimal "discount", precision: 8, scale: 2
		    t.decimal "shipping_cost", precision: 8, scale: 2
		    t.integer "shipping_detail_id"
		    t.string "state"
		end
	end
end
