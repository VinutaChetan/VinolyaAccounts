class Perticular < ActiveRecord::Base
	has_many :tansactions

	validates_presence_of :name
end
