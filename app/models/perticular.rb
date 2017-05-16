class Perticular < ActiveRecord::Base
	has_many :transactions

	validates_presence_of :name
end
