class Company < ActiveRecord::Base
	acts_as_paranoid
	
	has_many :banks
	has_many :accounts
	has_many :transactions
	
	validates_presence_of :name
end
