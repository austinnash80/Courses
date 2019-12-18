class EmpireMasterList < ApplicationRecord

  def self.my_import(file)
    batch,batch_size = [], 1_000
    CSV.foreach(file.path, headers: true, header_converters: :symbol, :encoding => 'iso-8859-1:utf-8') do |row|
      batch << EmpireMasterList.new(row.to_hash)
      if batch.size >= batch_size
        EmpireMasterList.import batch
          batch = []
    end
  end
    EmpireMasterList.import batch
  end

end
