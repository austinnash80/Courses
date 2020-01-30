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

end
