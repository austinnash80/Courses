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

  def self.to_csv # Export to csv function
    attributes = %w{lid list source uid}
    CSV.generate(headers: true) do |csv|
      csv << attributes

        all.each do |empire_master_list|
          csv << attributes.map{ |attr| empire_master_list.send(attr) }
        end
    end
  end

end
