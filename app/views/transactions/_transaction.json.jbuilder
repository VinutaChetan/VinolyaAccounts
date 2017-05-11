json.extract! transaction, :id, :transaction_date, :perticular_id, :transaction_type, :remark, :transaction_kind, :created_at, :updated_at
json.url transaction_url(transaction, format: :json)
