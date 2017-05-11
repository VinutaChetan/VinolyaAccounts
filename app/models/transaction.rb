class Transaction < ActiveRecord::Base
	belongs_to :perticular

	belongs_to :account
	validates_presence_of :transaction_date,:perticular_id,:transaction_type,:transaction_kind

	def self.list_view
		transaction=Transaction.order('transaction_date ASC').first
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
