# require './base'
# require 'faker'
# class Product < Base
# 	attr_accessor :name, :price
# 	@@products = []

# 	def initialize(data)
# 		@name = data["name"] 
# 		@price = data["price"]
# 		@@products.push(self)
# 	end

# 	def self.count 
# 		@@products.length
# 	end

# 	def self.find_by_name(name)
# 		super
# 	end

# 	def self.less_than_50
# 		super
# 	end

# end

# 100.times do 
# 	data = {
# 		"name" => Faker::Commerce.product_name,
# 		"price" => Faker::Commerce.price(1000)
# 	}
# 	Product.new(data)
# end

# puts Product.count

# puts Product.less_than_50.size




