class Product < ActiveRecord::Base
	has_many :product_reviews

	def average_rating
		if product_reviews.size>0 
			sum=product_reviews.collect { |oi| oi.rating}.sum
			return sum/product_reviews.size
		end
		return 0
	end

	def review_stars
		average_rating.round
	end

	def number_of_reviews
		product_reviews.size
	end
end