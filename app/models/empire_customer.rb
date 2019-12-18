class EmpireCustomer < ApplicationRecord

  def self.my_import(file)
    batch,batch_size = [], 1_000
    CSV.foreach(file.path, headers: true, header_converters: :symbol, :encoding => 'utf-8') do |row|
      batch << EmpireCustomer.new(row.to_hash)
      if batch.size >= batch_size
        EmpireCustomer.import batch
          batch = []
    end
  end
    EmpireCustomer.import batch
  end

  def self.to_csv # Export to csv function
    attributes = %w{uid lic_state fname lname email}
    CSV.generate(headers: true) do |csv|
      csv << attributes

        all.each do |empire_customer|
          csv << attributes.map{ |attr| empire_customer.send(attr) }
        end
    end
  end

end
