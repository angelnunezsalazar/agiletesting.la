require 'sinatra'
require "sinatra/content_for"
require 'sinatra/activerecord'
require 'sinatra/flash'
require './config/environments'
require './model/product'
require './model/product_tenant'
require './model/order'
require './model/order_item'
require './model/shipping_detail'
require './model/product_review'

require 'json'

set :public_folder, 'public'
set :views, File.dirname(__FILE__) + "/views"
enable :sessions

get '/' do
	@order_products_count=current_order.products_count
	@products=Product.all
	erb :"index"
end

get '/search' do
	@order_products_count=current_order.products_count

	@products=Product.where(["name LIKE ?", "%#{params[:query]}%"])
	erb :"index"
end

post '/add_to_cart' do
	order = current_order
	order.add_product(params[:product_id].to_i,params[:quantity].to_i)
	order.save
	order.order_items.each{|oi| oi.changed? && oi.save}
	session[:order_id] = order.id
	redirect '/cart'
end

post '/remove-item' do
	order = current_order
	order.remove_item(params[:order_item_id].to_i)
	order.save
	session[:order_id] = order.id
	redirect '/cart'
end

get '/cart' do
	@order_products_count=current_order.products_count
	@order=current_order
	erb :"cart"
end

get '/productdetails' do
	@order_products_count=current_order.products_count
	@product=Product.find(params["productid"])
	erb :"product_details"
end

get '/addreview' do
	@order_products_count=current_order.products_count
	@product=Product.find(params["productid"])
	erb :"review"
end

post '/addreview' do
	order = current_order

	@product_review=ProductReview.new
	@product_review.attributes = params
	

	previous_review=ProductReview.find_by(reviewer: @product_review.reviewer, 
										  product_id: @product_review.product_id)
	if !previous_review.nil?
		flash[:error] = "You have already a review to this product"
		redirect "/addreview?productid=#{@product_review.product_id}"
	end

	@product_review.review_date=Time.now
	@product_review.save

	redirect "/productdetails?productid=#{params[:product_id]}"
end

get '/shipping' do
	@order_products_count=current_order.products_count
	@delivery_options=DeliveryOption.all.order(:id)
	erb :"shipping"
end

post '/shipping' do
	order = current_order

	shipping_detail=ShippingDetail.new
	shipping_detail.attributes = params
	shipping_cost=100
	order.add_shipping(shipping_detail,shipping_cost)
	order.save

	redirect '/place-order'
end

post '/apply-coupon' do
	coupon=params['coupon']
	if !(coupon.nil? || coupon.empty?)
		discount=5
		order = current_order
		order.apply_discount(discount)
		order.save
	end
	redirect '/cart'
end

get '/place-order' do
	@order_products_count=current_order.products_count
	@order = current_order
	erb :"place_order"
end

post '/place-order' do
	order = current_order
	order.place_order
	order.save
	redirect '/confirmation'
end

get '/confirmation' do
	if session[:order_id].nil?
		redirect '/'
	end
	@order = current_order
	session.clear
	erb :"confirmation"
end

get '/ordersession' do
	if !session[:order_id].nil?
      	'Order ID:' + session[:order_id].to_s
    else
    	'No hay orden en session'
    end
end

get '/clear' do
	session.clear
	redirect '/'
end

def current_order
    if !session[:order_id].nil?
      	Order.find(session[:order_id])
    else
    	Order.new
    end
end

################ Tenant #####################

get '/tenantsearch' do
	@order_products_count=current_order.products_count
	@products=ProductTenant.where(["tenant = ? and name LIKE ?",params[:tenant], "%#{params[:query]}%"])
	@tenant=params[:tenant]
	erb :"index"
end

post '/loadproducts' do
	ProductTenant.load(params[:tenant])
	redirect "/#{params[:tenant]}"
end

get '/:tenant' do
	@order_products_count=current_order.products_count
	@products=ProductTenant.where("tenant = ?",params[:tenant])
	if @products.size == 0
		@new_tenant=true;
	end
	@tenant=params[:tenant]
	erb :"index"
end

################ API #####################

get '/api/allproducts/' do
	products=Product.all
	products.to_json
end

get '/api/allproducts/:tenant' do
	products=ProductTenant.where(tenant: params[:tenant])
	products.to_json
end

get '/api/deleteproducts/:tenant' do
	ProductTenant.delete_all(tenant: params[:tenant])
	{ :result => 'Successfully'}.to_json
end

post '/api/addproduct/' do
	new_product = JSON.parse(request.body.read)

	@product=Product.new
	@product.name = new_product["name"]
	@product.description = new_product["description"]
	@product.price = new_product["price"]
	@product.author = new_product["author"]
	@product.save
	{ :result => 'Successfully'}.to_json
end

post '/api/addproduct/:tenant' do
	new_product = JSON.parse(request.body.read)

	@product=ProductTenant.new
	@product.tenant = new_product["tenant"]
	@product.name = new_product["name"]
	@product.description = new_product["description"]
	@product.price = new_product["price"]
	@product.author = new_product["author"]
	@product.save
	{ :result => 'Successfully'}.to_json
end

get '/api/allreviews/:reviewer' do
	reviews=ProductReview.where(reviewer: params[:reviewer])
	reviews.to_json
end

get '/api/deletereviews/:reviewer' do
	ProductReview.delete_all(reviewer: params[:reviewer])
	{ :result => 'Successfully'}.to_json
end

