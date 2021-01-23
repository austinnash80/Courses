class MasterCpaNoMatch < ApplicationRecord

  validates :uid, :presence => true, :uniqueness => true

  def self.my_import(file)
    batch,batch_size = [], 2_000
    CSV.foreach(file.path, headers: true, header_converters: :symbol, :encoding => 'utf-8') do |row|
      batch << MasterCpaNoMatch.new(row.to_hash)
      if batch.size >= batch_size
        MasterCpaNoMatch.import batch
          batch = []
    end
  end
    MasterCpaNoMatch.import batch
  end

  def self.to_csv # Export to csv function
    attributes = %w{uid list lname search_date}
    CSV.generate(headers: true) do |csv|
      csv << attributes

        all.each do |master_cpa_no_match|
          csv << attributes.map{ |attr| master_cpa_no_match.send(attr) }
        end
    end
  end

end
