class Account < ActiveRecord::Base
	belongs_to :branch
	belongs_to :bank

	has_many :transactions

	validates_presence_of :acc_no,:opening_balance,:bank_id,:branch_id,:acc_type,:current_balance
	validates_length_of :acc_no,is:11
end
