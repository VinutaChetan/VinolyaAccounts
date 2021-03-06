class Transaction < ActiveRecord::Base

	attr_accessor :formatted_date
	attr_accessor :formattedinstru_date
	acts_as_paranoid
	
	belongs_to :perticular
	belongs_to :company
	belongs_to :account
	
	validates_presence_of :transaction_date,:company_id,:account_id,:perticular_id,
							:transaction_type,:amount,:transaction_kind,:instrument_date,:instrument_number
	validates_numericality_of :amount
	validates_uniqueness_of :instrument_number

	after_save :add_acc_balance
	after_save :update_current_account_balance

	validate :set_balance, :on => :create 
	
	after_destroy :update_current_balance
	before_destroy :update_balance

	validate :check_balance, :on =>:create
	validate :update_check_balance,:on =>:update

	# def amount_was
	# 	return self.amount
	# end
	def update_balance
		tran = Transaction.where( 'account_id = ? AND created_at > ?',self.account_id, self.created_at)
		tran.each do |trans|
			if(self.transaction_type == "debit")
				if(trans.transaction_type == "credit")
					trans.balance = trans.balance + self.amount
				else 
					trans.balance = trans.balance - self.amount	
				end	
			else
				binding.pry
				if(trans.transaction_type == "credit")
					trans.balance = trans.balance - self.amount
					binding.pry
				else 
					trans.balance = trans.balance + self.amount	
					binding.pry
				end	
			end	
			trans.save
		end	

	end	
	
	def set_balance
		if(self.transaction_type == "credit")
			self.balance = self.account.current_balance + self.amount
		else
			self.balance = self.account.current_balance - self.amount	
		end	
	end	

	# def cascade(amount_was)
	# 	# if(self.transaction_type == "credit")
	# 		# binding.pry
	# 		diff_plus = self.amount  + amount_was
	# 		diff_minus = amount_was - self.amount
	# 		t = Transaction.where( 'account_id = ? AND created_at >= ?',self.account_id, self.created_at)
	# 		# binding.pry
	# 		t.each do |trans|
	# 			if(trans.transaction_type == "credit" and trans.transaction_type_was == "credit" )
	# 				trans.balance = trans.balance + diff_minus
	# 				# binding.pry
	# 			elsif(trans.transaction_type == "credit" and trans.transaction_type_was == "debit" )
	# 				binding.pry
	# 				trans.balance = trans.balance - diff_plus	
	# 				binding.pry
	# 			elsif(trans.transaction_type == "debit" and trans.transaction_type_was == "debit" )
	# 				trans.balance = trans.balance - diff_minus	
	# 				# binding.pry
	# 			elsif(trans.transaction_type == "debit" and trans.transaction_type_was == "credit" )
	# 				trans.balance = trans.balance + diff_plus	
	# 				# binding.pry
	# 			end
	# 			trans.save
	# 			# break

	# 		end
	# 	# end
	#  end	
	def check_bal(tran,temp)
		tran.each do |trans|
				if(trans.transaction_type == "credit" )
					trans.balance= temp + trans.amount
				else 
					trans.balance= temp - trans.amount	
				end	
				trans.save
				temp=trans.balance
			end	
	end	

	def cascade
		t = Transaction.where( 'account_id = ? AND created_at < ?',self.account_id , self.created_at).last
		if t.present?
			t.balance
			temp = t.balance
			tran = Transaction.where( 'account_id = ? AND created_at >= ?',self.account_id, self.created_at)
			check_bal(tran,temp)
		else
			if(self.transaction_type == "credit" )
				self.balance = self.account.opening_balance + self.amount
			else
				self.balance = self.account.opening_balance - self.amount
			end	
			self.save
			temp = self.balance
			tran = Transaction.where( 'account_id = ? AND created_at > ?',self.account_id, self.created_at)
			check_bal(tran,temp)
		end	
	end	


	#for show error if the transaction type is not overdraft and it is debit , amount should not goies to negative while creating.
	def check_balance
			if(self.transaction_type == "debit" && self.account.acc_type != "Over Draft")
				balance = self.account.current_balance - self.amount
				if(balance<0)
					errors.add(:base,"amount should be less than #{self.account.current_balance}");
				end	
			end	
	end	

	def update_check_balance
		if !self.created_at_changed?
			if(self.transaction_type == "debit" && self.account.acc_type != "Over Draft")
				if(self.transaction_type_was == "credit")
					current_balance = self.account.current_balance - self.amount_was
					if(self.account.current_balance!=0)
						balance = current_balance - self.amount	
						if(balance < 0)
							errors.add(:base,"amount should be less than #{current_balance}");
						end	
					else
						if(self.account.current_balance == 0)
							errors.add(:base,"You can't debit because amount is Rs.0 ")
						end	
					end
				else
					current_balance = self.account.current_balance + self.amount_was
					if(current_balance!=0)
						balance = current_balance - self.amount	
						if(balance < 0)
							errors.add(:base,"amount should not be greater than #{current_balance}")
						end	
						if(balance == 0)
							errors.add(:base,"amount should  be less than #{current_balance}")
						end	
					else 
						if(current_balance == 0)
							errors.add(:base,"amount should not be less than RS .0")
						end	
					end

				end	
			end	
		end	
	end	

	# this method is for changing the incoming date format from dd-mm-yy to yy-mm-dd 
	def formulate_date(form_date)
		date_array = form_date.split("-").map! {|v| v.to_i}
		self.transaction_date = Date.new(date_array[2], date_array[1],date_array[0]) if !date_array.empty?
	end

	# this method is for changing the outgoing date format from yy-mm-dd to dd-mm-yy
	def formatted_date
		format_str = ""
		date_array = self.transaction_date.to_s.split('-')
		format_str += "#{date_array[2]}-#{date_array[1]}-#{date_array[0]}"
		# binding.pry
		return format_str == "--" ? nil : format_str
	end

	def formulateinstru_date(form_date)
		date_array = form_date.split("-").map! {|v| v.to_i}
		self.instrument_date = Date.new(date_array[2], date_array[1],date_array[0]) if !date_array.empty?
	end	

	# this method is for changing the outgoing date format from yy-mm-dd to dd-mm-yy
	def formattedinstru_date
		format_str = ""
		date_array = self.instrument_date.to_s.split('-')
		format_str += "#{date_array[2]}-#{date_array[1]}-#{date_array[0]}"
		return format_str == "--" ? nil : format_str
	end


	def self.list_view(current_account) 
		if current_account !=nil

		transaction = current_account.transactions.order('transaction_date ASC').first
		
		if transaction == nil
			return "No Transaction found"
		else
		start_year=transaction.transaction_date.year
		end_year=Date.today.year
    	months = ['January','February','March','April','May','June','July','August','September','October','November','December']
		data = {}

		while(start_year<=end_year)
			data_month = {}
			months.each_with_index do |month, index|
				
				query_start_date = Date.parse("#{start_year}-#{index + 1}-1")
				query_end_date = query_start_date.end_of_month
				data_month[month] = current_account.transactions.where('transaction_date >= ? AND transaction_date <= ?',query_start_date, query_end_date)
			
			end
			data[start_year] = [data_month]
			start_year = start_year + 1
		end
		return data	
		end

		else
			Account.all
		end	
	end

	def self.list
		transaction = Transaction.order('transaction_date ASC').first
		
		if transaction == nil
			return "No Transaction found"
		else
		start_year=transaction.transaction_date.year
		end_year=Date.today.year
    	months = ['January','February','March','April','May','June','July','August','September','October','November','December']
		data = {}

		while(start_year<=end_year)
			data_month = {}
			months.each_with_index do |month, index|
				
				query_start_date = Date.parse("#{start_year}-#{index + 1}-1")
				query_end_date = query_start_date.end_of_month
				data_month[month] = Transaction.where('transaction_date >= ? AND transaction_date <= ?',query_start_date, query_end_date)
			
			end
			data[start_year] = [data_month]
			start_year = start_year + 1
		end
		return data
		
	end
	end
	
	def update_current_account_balance
		if !self.created_at_changed?
			account=Account.find_by(id: self.account.id)
			if (self.transaction_type_was == "credit")
				current_balance = account.current_balance - self.amount_was
			else
				current_balance = account.current_balance + self.amount_was
			end
			if (self.transaction_type=="credit")
				#current_balance = account.current_balance - self.amount_was
				account.current_balance = self.amount + current_balance
			else (self.transaction_type=="debit")
				#current_balance = account.current_balance + self.amount_was 
				account.current_balance = current_balance - self.amount
			end
			#account.current_balance = self.balance
			account.save
		end
	end		


	def add_acc_balance
		if self.created_at_changed?
			if (self.transaction_type=="credit")
				account=Account.find_by(id: self.account.id)
				account.current_balance =self.amount+account.current_balance
			else 
				account=Account.find_by(id: self.account.id)
				account.current_balance =account.current_balance-self.amount
			end
			account.save
		end
	end		

	def update_current_balance
		account=Account.find_by(id: self.account.id)
		if (self.transaction_type=="credit")
			account.current_balance =account.current_balance-self.amount
			account.save
		else 
			account.current_balance =self.amount+account.current_balance
			account.save
		end		
	end	

	def self.list_cr_amount
		#ordering of transaction date in ascending order and taking the first object
		transaction=Transaction.order('transaction_date ASC').first
		#getting the start_year as a first object year
		start_year=transaction.transaction_date.year
		#getting  end_year as a todays year
		end_year=Date.today.year
		#take on array of months 
    	months = ['January','February','March','April','May','June','July','August','September','October','November','December']
		#take one empty hash
		data = {}
		#data_debit={}
		#Scr_dr={}
		#check condition that first year date should be less than or equal to todats year
		while(start_year<=end_year)
			#empty hash
			data_month = {}
			data_mon_debit={}
			#itterating over an array months
			months.each_with_index do |month, index|
				#where start date is start_year-01-1 
				query_start_date = Date.parse("#{start_year}-#{index + 1}-1")
				#where end date is start_year-01-1 end of this year
				query_end_date = query_start_date.end_of_month
				
				#putting key as month and value as transaction  sum of amount between start_year-01-1 and start_year-01-1 end of this year 
				data_month[month] = Transaction.where('transaction_date >= ? AND transaction_date <= ? AND transaction_type=?' ,query_start_date, query_end_date,"credit").sum(:amount)
			
				data_mon_debit[month] = Transaction.where('transaction_date >= ? AND transaction_date <= ? AND transaction_type=?' ,query_start_date, query_end_date,"debit").sum(:amount)
				
			end
			#putting key as start_year and value as monthwise transactions strat_year as a key and datamonth contains key as month and value as monthwise transactions
			data[start_year] = [data_month]
			#data_debit[start_year] = [data_mon_debit]
			
			#year should be increse to next index
			start_year = start_year + 1
		end
		# cr_dr={}
		# types=["credit","debit"]
		# cr_dr[types]=
		return data
		#return data_debit
		#return cr_dr
	end	


	def self.list_dr_amount
		#ordering of transaction date in ascending order and taking the first object
		transaction=Transaction.order('transaction_date ASC').first
		#getting the start_year as a first object year
		start_year=transaction.transaction_date.year
		#getting  end_year as a todays year
		end_year=Date.today.year
		#take on array of months 
    	months = ['January','February','March','April','May','June','July','August','September','October','November','December']
		#take one empty hash
		data = {}
		data_debit={}
		
		#check condition that first year date should be less than or equal to todats year
		while(start_year<=end_year)
			#empty hash
			data_month = {}
			data_mon_debit={}
			#itterating over an array months
			months.each_with_index do |month, index|
				#where start date is start_year-01-1 
				query_start_date = Date.parse("#{start_year}-#{index + 1}-1")
				#where end date is start_year-01-1 end of this year
				query_end_date = query_start_date.end_of_month
				
				#putting key as month and value as transaction  sum of amount between start_year-01-1 and start_year-01-1 end of this year 
				data_month[month] = Transaction.where('transaction_date >= ? AND transaction_date <= ? AND transaction_type=?' ,query_start_date, query_end_date,"credit").sum(:amount)
			
				data_mon_debit[month] = Transaction.where('transaction_date >= ? AND transaction_date <= ? AND transaction_type=?' ,query_start_date, query_end_date,"debit").sum(:amount)
				
			end
			#putting key as start_year and value as monthwise transactions strat_year as a key and datamonth contains key as month and value as monthwise transactions
			#data[start_year] = [data_month]
			data_debit[start_year] = [data_mon_debit]
			
			#year should be increse to next index
			start_year = start_year + 1
		end
		return data_debit
		#return cr_dr
	end	

	def restore_transaction
		if self.transaction_type == "credit"
			account=Account.find_by(id: self.account.id)
			account.current_balance =self.amount+account.current_balance
			account.save
		else
			account=Account.find_by(id: self.account.id)
			account.current_balance =account.current_balance-self.amount
			account.save
		end

		tran = Transaction.where( 'account_id = ? AND created_at > ?',self.account_id, self.created_at)
		tran.each do |trans|
			if(self.transaction_type == "debit")
				if(trans.transaction_type == "credit")
					trans.balance = trans.balance - self.amount
				else 
					trans.balance = trans.balance + self.amount	
				end	
			else
				if(trans.transaction_type == "credit")
					trans.balance = trans.balance + self.amount
				else 
					trans.balance = trans.balance - self.amount	
				end	
			end	
			trans.save
		end	

	end

end
