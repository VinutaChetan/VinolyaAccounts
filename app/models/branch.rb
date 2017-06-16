class Branch < ActiveRecord::Base
	acts_as_paranoid
	
	has_many :banks

	has_many :accounts
	
	validates_presence_of :name
end
