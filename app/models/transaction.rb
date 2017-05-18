class Transaction < ActiveRecord::Base
	belongs_to :perticular

	belongs_to :account
	validates_presence_of :transaction_date,:perticular_id,:transaction_type,:transaction_kind

	after_create :add_acc_balance

	def self.list_view

		transaction=Transaction.order('transaction_date ASC').first
		
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
		if (self.transaction_type=="credit")
			account=Account.find_by(id: self.account.id)
			account.current_balance =self.amount+account.current_balance
			account.save
		else 
			account=Account.find_by(id: self.account.id)
			account.current_balance =account.current_balance-self.amount
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


end
