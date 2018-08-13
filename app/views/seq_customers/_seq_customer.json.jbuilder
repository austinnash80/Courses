json.extract! seq_customer, :id, :order_id, :uid, :purchase, :product_1, :product_2, :designation, :fname, :lname, :street_1, :street_2, :city, :state, :zip, :email, :price_2, :lic_num, :created_at, :updated_at
json.url seq_customer_url(seq_customer, format: :json)
