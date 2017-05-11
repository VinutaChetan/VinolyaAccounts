class Branch < ActiveRecord::Base
	has_many :banks

	has_many :accounts
	
	validates_presence_of :name
end
