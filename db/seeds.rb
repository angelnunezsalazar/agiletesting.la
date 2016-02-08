Product.delete_all
product1=Product.create(name:'Carrot Cake',		description:'A scrumptious mini-carrot cake encrusted with sliced almonds',			price:8.99,img:'carrot_cake.jpg')
product2=Product.create(name:'Cupcakes',		description:'Delectable vanilla and chocolate cupcakes',							price:5.99,img:'cupcakes.jpg')
product3=Product.create(name:'Lemon Tart',		description:'A delicious lemon tart with fresh meringue cooked to perfection',		price:9.99,img:'lemon_tart.jpg')
product4=Product.create(name:'Bread',			description:'Fresh baked French-style bread',										price:1.49,img:'bread.jpg')
product5=Product.create(name:'Pear Tart',		description:'A glazed pear tart topped with sliced almonds and a dash of cinnamon',	price:5.99,img:'pear_tart.jpg')
product6=Product.create(name:'Chocolate Cake',	description:"Rich chocolate frosting cover this chocolate lover's dream.",			price:8.99,img:'chocolate_cake.jpg')

ProductReview.delete_all
ProductReview.create(reviewer:'John Doe' 		,comment:'lo recomiendo!, muy entretenido',	rating:5,review_date:Time.now,product:product1);
ProductReview.create(reviewer:'Luis Rodriguez' 	,comment:'estuvo meh!',						rating:1,review_date:Time.now,product:product1);


DeliveryOption.delete_all
DeliveryOption.create(name:'FREE Shipping (5-8 business days)',		min_days:5,max_days:8,business_day:true)
DeliveryOption.create(name:'Standard Shipping (4-5 business days)',	min_days:3,max_days:5,business_day:true,default_active:true)
DeliveryOption.create(name:'Two-Day Shipping',						min_days:2,max_days:2,business_day:false)

