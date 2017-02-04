class ProductsTenant < ActiveRecord::Migration
	def change
		create_table "product_tenants", force: :cascade do |t|
		    t.string  "name"
		    t.string  "description"
		    t.string  "author"
		    t.decimal "price",       precision: 8, scale: 2
		    t.string  "img"
		    t.string  "tenant"
		end
	end
end