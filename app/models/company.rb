class Company < ActiveRecord::Base
	acts_as_paranoid
	
	has_many :banks
	has_many :accounts
	has_many :transactions
	
	validates_presence_of :name,:contact_number,:address,:mail_id
	validates_format_of :mail_id, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
end
