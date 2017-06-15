class Account < ActiveRecord::Base
	belongs_to :branch
	belongs_to :bank
	belongs_to :company
	has_many :transactions

	validates_presence_of :acc_no,:opening_balance,:bank_id,:branch_id,:acc_type,:current_balance,:company_id
	validates_uniqueness_of :acc_no
	validates_numericality_of :opening_balance,:current_balance

end
