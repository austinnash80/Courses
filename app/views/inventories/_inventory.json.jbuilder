json.extract! inventory, :id, :company, :version, :number, :note, :extra_s, :extra_i, :extra_b, :created_at, :updated_at
json.url inventory_url(inventory, format: :json)
