class Branch < ActiveRecord::Base
	has_many :banks

	has_many :accounts
end
