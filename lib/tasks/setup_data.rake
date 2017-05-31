task :setup_data => :environment do 
	 

	 # 9.times do 
		# company=Company.new
		# company.name=Faker::Company.name
		# company.save 
	 # end 

	# 10.times do 
 # 		branch=Branch.new
 # 		z=0
 # 		while z!=1 do 
 # 			branch.name=Faker::Address.street_name	
 # 			k=Branch.uniq.pluck(:name)
 # 			if  !(k.include?branch.name)
 # 				branch.save 
 # 				z=1
 # 			end	
	# 	end	
	# end

	# 9.times do 
	# 	perticular=Perticular.new
	# 	perticular.name=Faker::Name.name 
	# 	perticular.save 
	#  end 

	# 9.times do 
	# 	bank=Bank.new
	# 	bank.name=Faker::Bank.name
	# 	bank.address=Faker::Address.street_address
	# 	bank.manager=Faker::Name.name 
	# 	bank.contact_details=Faker::PhoneNumber.cell_phone
	# 	bank.branch_id=Branch.all.pluck(:id).sample
	# 	bank.company_id=Company.all.pluck(:id).sample
	# 	bank.save 
	# end 

	# account_type=["current account","savings"]
	# 10.times do 
	# 	account=Account.new
	# 	account.acc_no=Faker::Number.number(11)
	# 	account.opening_balance=Faker::Number.between(-5000,5000)
	# 	account.bank_id=Bank.all.pluck(:id).sample
	# 	account.branch_id=Branch.all.pluck(:id).sample 
	# 	account.acc_type=account_type.sample
	# 	account.current_balance=Faker::Number.between(-200000,500000)
	# 	account.save
	# end

	# trans_type=["debit","credit"]
	# trans_kind=["RTGE","cheque","cash"]
	# 1400.times do 
	# 	transaction=Transaction.new
	# 	transaction.transaction_date=Faker::Date.between(2.year.ago, Date.today)
	# 	transaction.perticular_id=Perticular.all.pluck(:id).sample 
	# 	transaction.transaction_type=trans_type.sample
	# 	transaction.remark=Faker::Lorem.sentence
	# 	transaction.transaction_kind=trans_kind.sample
	# 	transaction.save
	# end		

	# Transaction.all.each do |transaction| 
	# 	transaction.account_id = Account.all.pluck(:id).sample 
	# 	transaction.save
	# end	

	# Transaction.all.each do |transaction|
	# 	transaction.amount=Faker::Number.between(1000,8000)
	# 	transaction.save
	# end

	# Account.all.each do |account|
	# 	account.company_id=Company.all.pluck(:id).sample
	# 	account.save
	# end	

	# Transaction.all.each do |transaction|
	# 	transaction.company_id=Company.all.pluck(:id).sample
	# 	transaction.save
	# end	

	# Bank.all.each do |bank|
	# 	bank.link=Faker::Internet.url
	# 	bank.save
	# end	

#dont run below ever
	# Account.all.each do |acc|
	# 	acc.branch_id=Branch.all.pluck(:id).sample 
	# 	acc.save
	# end	
end	


