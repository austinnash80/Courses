json.extract! empire_customer, :id, :uid, :license_num, :existing, :purchase_date, :lic_state, :products, :order_total, :fname, :lname, :company, :street_1, :street_2, :city, :state, :zip, :email, :phone, :created_at, :updated_at
json.url empire_customer_url(empire_customer, format: :json)
