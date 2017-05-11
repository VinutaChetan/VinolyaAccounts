class Bank < ActiveRecord::Base
	belongs_to :branch
	belongs_to :company

	has_many :accounts

	validates_presence_of :name,:address,:manager,:contact_details,:branch_id,:company_id
end
