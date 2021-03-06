class EmpireMasterNoMatch < ApplicationRecord
  def self.my_import(file)
    batch,batch_size = [], 1_000
    CSV.foreach(file.path, headers: true, header_converters: :symbol, :encoding => 'iso-8859-1:utf-8') do |row|
      batch << EmpireMasterNoMatch.new(row.to_hash)
      if batch.size >= batch_size
        EmpireMasterNoMatch.import batch
          batch = []
    end
  end
    EmpireMasterNoMatch.import batch
  end

  def self.to_csv # Export to csv function
    attributes = %w{uid last_name list source search_date double}
    CSV.generate(headers: true) do |csv|
      csv << attributes

        all.each do |empire_master_no_match|
          csv << attributes.map{ |attr| empire_master_no_match.send(attr) }
        end
    end
  end
end
