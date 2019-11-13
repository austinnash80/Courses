json.extract! s_customer, :id, :s_id, :order_id, :uid, :existing, :purchase_s, :purchase, :product_1, :product_2, :designation, :fname, :lname, :street_1, :street_2, :city, :state, :zip, :email, :price_s, :price, :lic_num, :lic_state, :created_at, :updated_at
json.url s_customer_url(s_customer, format: :json)
