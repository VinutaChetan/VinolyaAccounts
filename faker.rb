require 'faker'
# 1.times do 
# 	company=Company.new
# 	company.name= Faker::Company.name
# 	company.save
# end
	
# 10.times do 
# 	branch=Branch.new
# 	branch.name=Faker::Address.street_name.unique 
# 	branch.save 
# end	

# 1.times do 
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
# 	account.acc_type=account_type.random
# 	account.current_balance=Faker::Number.between(-200000,500000)
# 	account.save
# end

# 10.times do 
# 	perticular=Perticular.new 
# 	perticular.name=Faker::Name.name
# 	perticular.save
# end

# trans_type=["debit","credit"]
# trans_kind=["RTGE","cheque","cash"]
# 100.times do 
# 	transaction=Transaction.new
# 	transaction.transaction_date=Faker::Date.between_except(1.year.ago, Date.today)
# 	transaction.perticular_id=Perticular.all.pluck(:id).sample 
# 	tansaction.transaction_type=trans_type.random
# 	transaction.remark=Faker::Lorem.sentence
# 	transaction.transaction_kind=trans_kind.random
# 	transaction.save
# end		





