class Perticular < ActiveRecord::Base
	acts_as_paranoid
	
	has_many :transactions

	validates_presence_of :name,:perticular_type
	validates_uniqueness_of :name

	
end
