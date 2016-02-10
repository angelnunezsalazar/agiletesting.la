require 'business_time'

class ShippingDetail< ActiveRecord::Base
	belongs_to :delivery_option

end

class DeliveryOption < ActiveRecord::Base

	FREE_SHIPPING = "1"
  	STANDARD_SHIPPING = "2"
  	EXPEDITED_SHIPPING = "3"	

	def delivery_date
		if self.business_day
			min_date=self.min_days.business_days.from_now
			max_date=self.max_days.business_days.from_now
		else
			min_date=self.min_days.days.from_now
			max_date=self.max_days.days.from_now
		end
		if min_days==max_days
			return min_date.strftime("%b %d, %Y")
		end
		return min_date.strftime("%b %d, %Y") + " - " + max_date.strftime("%b %d, %Y")
	end
end