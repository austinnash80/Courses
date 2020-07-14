class MasterEa < ApplicationRecord
  def self.my_import(file)
    batch,batch_size = [], 2_000
    CSV.foreach(file.path, headers: true, header_converters: :symbol, :encoding => 'utf-8') do |row|
      batch << MasterEa.new(row.to_hash)
      if batch.size >= batch_size
        MasterEa.import batch
          batch = []
    end
  end
    MasterEa.import batch
  end
end
