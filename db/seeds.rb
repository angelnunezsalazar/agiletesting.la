Product.delete_all
product1=Product.create(name:'Agile Testing: A Practical Guide for Testers and Agile Teams',description:'', author: 'Lisa Crispin, Janet Gregory', price:45.58,img:'agile_testing.jpg')
product2=Product.create(name:'Automated Software Testing: Introduction, Management, and Performance: Introduction, Management, and Performance ',description:'',author:	'Elfriede Dustin, Jeff Rashka, John Paul',price:57.12,img:'automated_software_testing.jpg')
product3=Product.create(name:'Fifty Quick Ideas To Improve Your Tests',description:'', author:	'Gojko Adzic, David Evans, Tom Roden', price:24.99,img:'fifty_quick_ideas.jpg')
product4=Product.create(name:'How Google Tests Software', description:'', author:'James A. Whittaker, Jason Arbon, Jeff Carollo', price:27.16,img:'how_google_test_software.jpg')
product5=Product.create(name:'More Agile Testing: Learning Journeys for the Whole Team',description:'',	author:	'Lisa Crispin, Janet Gregory', price:40.45,img:'more_agile_testing.jpg')
product6=Product.create(name:'Software Test Automation', description:'', author:'Mark Fewster, Dorothy Graham',price:46.90,img:'software_test_automation.jpg')
product7=Product.create(name:'Experiences of Test Automation: Case Studies of Software Test Automation', description:'', author:'Dorothy Graham, Mark Fewster',price:48.72,img:'experiences_test_automation.jpg')
product8=Product.create(name:'Explore It!: Reduce Risk and Increase Confidence with Exploratory Testing', description:'Elisabeth Hendrickson', author:'Mark Fewster, Dorothy Graham',price:26.65,img:'explore_it.jpg')


ProductReview.delete_all
ProductReview.create(reviewer:'John Doe' 		,comment:'lo recomiendo!, muy entretenido',	rating:5,review_date:Time.now,product:product1);
ProductReview.create(reviewer:'Luis Rodriguez' 	,comment:'estuvo meh!',						rating:1,review_date:Time.now,product:product1);


DeliveryOption.delete_all
DeliveryOption.create(name:'FREE Shipping (5-8 business days)',		min_days:5,max_days:8,business_day:true)
DeliveryOption.create(name:'Standard Shipping (4-5 business days)',	min_days:3,max_days:5,business_day:true,default_active:true)
DeliveryOption.create(name:'Two-Day Shipping',						min_days:2,max_days:2,business_day:false)

