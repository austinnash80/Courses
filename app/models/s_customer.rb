class SCustomer < ApplicationRecord

  validates_uniqueness_of :s_id; true

  def self.my_import(file)
    batch,batch_size = [], 1_000
    CSV.foreach(file.path, headers: true, header_converters: :symbol, :encoding => 'utf-8') do |row|
      batch << SCustomer.new(row.to_hash)
      if batch.size >= batch_size
        SCustomer.import batch
          batch = []
    end
  end
  SCustomer.import batch

end

def self.to_csv # Export to csv function
  attributes = %w{s_id order_id uid existing purchase_s purchase product_1 product_2 designation fname lname street_1 street_2 city state zip email price_s price lic_num lic_state total}
  CSV.generate(headers: true) do |csv|
    csv << attributes

      all.each do |s_customer|
        csv << attributes.map{ |attr| s_customer.send(attr) }
      end
  end
end

end
