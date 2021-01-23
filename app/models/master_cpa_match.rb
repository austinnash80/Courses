class MasterCpaMatch < ApplicationRecord

  validates :lid, :presence => true, :uniqueness => true

  def self.my_import(file)
    batch,batch_size = [], 2_000
    CSV.foreach(file.path, headers: true, header_converters: :symbol, :encoding => 'utf-8') do |row|
      batch << MasterCpaMatch.new(row.to_hash)
      if batch.size >= batch_size
        MasterCpaMatch.import batch
          batch = []
    end
  end
    MasterCpaMatch.import batch
  end

  def self.to_csv # Export to csv function
    attributes = %w{lid list uid lname search_date}
    CSV.generate(headers: true) do |csv|
      csv << attributes

        all.each do |master_cpa_match|
          csv << attributes.map{ |attr| master_cpa_match.send(attr) }
        end
    end
  end

end
