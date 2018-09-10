json.extract! sequoia_customer, :id, :unique_id, :order_id, :uid, :purchase_date, :product, :who, :type, :hours, :price, :fname, :lname, :street_1, :street_2, :city, :state, :state, :zip, :email, :lic_num, :created_at, :updated_at
json.url sequoia_customer_url(sequoia_customer, format: :json)
