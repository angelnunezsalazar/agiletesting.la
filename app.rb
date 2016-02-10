require 'sinatra'
require "sinatra/content_for"
require 'sinatra/activerecord'
require './config/environments'
require './model/product'
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