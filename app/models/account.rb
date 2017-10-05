class Account < ActiveRecord::Base
	acts_as_paranoid

	belongs_to :branch
	belongs_to :bank
	belongs_to :company
	has_many :transactions

	validates_presence_of :acc_no,:opening_balance,:bank_id,:branch_id,:acc_type,:current_balance,:company_id
	validates_uniqueness_of :acc_no
	validates_numericality_of :opening_balance,:current_balance

	validate :check_acc_balance, :on =>:create
	
	def check_acc_balance
			if(self.opening_balance != self.current_balance)
				errors.add(:base,"current balance amount should be equal to the #{self.opening_balance}");
			end	
	end	

	# def readonly
 # 		 return true unless new_record?
	# end
end
