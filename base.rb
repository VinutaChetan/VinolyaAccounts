class Base 

	def self.find_by_name(name) 
		self.find_all{|obj| obj.name == name}
	end

	def self.less_than_50
		self.find_all{|obj| obj.price < 50 }
	end

end