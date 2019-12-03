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

end
