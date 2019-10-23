class MasterList < ApplicationRecord

  def self.my_import(file)
    batch,batch_size = [], 2_000
    CSV.foreach(file.path, headers: true, header_converters: :symbol, :encoding => 'utf-8') do |row|
      batch << MasterList.new(row.to_hash)
      if batch.size >= batch_size
        MasterList.import batch
          batch = []
    end
  end
    MasterList.import batch
  end

end
