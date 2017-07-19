class Transaction < ActiveRecord::Base
	 acts_as_paranoid
	
	belongs_to :perticular
	belongs_to :company
	belongs_to :account
	
	validates_presence_of :transaction_date,:company_id,:account_id,:perticular_id,
							:transaction_type,:amount,:transaction_kind,:instrument_date,:instrument_number
	validates_numericality_of :amount
	validates_uniqueness_of :instrument_number

	before_create :change_date_format
	after_save :add_acc_balance
	after_destroy :update_current_balance


	def self.list_view(current_account) 
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
	


	def add_acc_balance
		account=Account.find_by(id: self.account.id)
		if (self.transaction_type=="credit")
			account.current_balance =self.amount+account.current_balance
		else 
			account.current_balance =account.current_balance-self.amount
		end
		account.save
	end		

	def update_current_balance
		if (self.transaction_type=="credit")
			account=Account.find_by(id: self.account.id)
			account.current_balance =account.current_balance-self.amount
			account.save
		else 
			account=Account.find_by(id: self.account.id)
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
		# cr_dr={}
		# types=["credit","debit"]
		# cr_dr[types]=
		#return data
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
	end

	def change_date_format
		trans_date = self.transaction_date.strftime("%d-%m-%Y").split("-") 
		year = "20" +  trans_date.first
		day = trans_date.last.split("")
		input_day = day[2]+day[3]
		self.transaction_date = year + "-" + trans_date[1] + "-" +input_day
		self.transaction_date.strftime("%d-%m-%Y")
		

		 instru_date = self.instrument_date.strftime("%d-%m-%Y").split("-") 
		 
		instru_year = "20" +  instru_date.first
		instru_day = instru_date.last.split("")
		 instru_input_day = instru_day[2]+instru_day[3]
		 self.instrument_date = instru_year + "-" + instru_date[1] + "-" + instru_input_day
		 
		 self.instrument_date.strftime("%d-%m-%Y")



		# trans_date = self.transaction_date.strftime("%d-%m-%Y").split("-").reverse.join("-")
		# #binding.pry
		# year = "20" + trans_date.first
		# self.transaction_date = year + "-" + trans_date[1] + "-" + trans_date[2]
		# #binding.pry
		# self.save

		# instru_date = self.instrument_date.strftime("%d-%m-%Y").split("-").reverse.join("-")
		# year = "20" + instru_date.first
		# self.instrument_date = year + "-" + instru_date[1] + "-" + instru_date[2]
		# self.save
	end	


end
