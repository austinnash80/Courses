class MasterCpa < ApplicationRecord
  def self.my_import(file)
    batch,batch_size = [], 2_000
    CSV.foreach(file.path, headers: true, header_converters: :symbol, :encoding => 'utf-8') do |row|
      batch << MasterCpa.new(row.to_hash)
      if batch.size >= batch_size
        MasterCpa.import batch
          batch = []
    end
  end
    MasterCpa.import batch
  end

end
