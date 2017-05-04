json.extract! account, :id, :acc_no, :opening_balance, :bank_id, :branch_id, :acc_type, :current_balance, :created_at, :updated_at
json.url account_url(account, format: :json)
