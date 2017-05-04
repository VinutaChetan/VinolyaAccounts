class Bank < ActiveRecord::Base
	belongs_to :branch
	belongs_to :company

	has_many :accounts
end
