class MasterEaNoMatch < ApplicationRecord

  def self.my_import(file)
    batch,batch_size = [], 2_000
    CSV.foreach(file.path, headers: true, header_converters: :symbol, :encoding => 'utf-8') do |row|
      batch << MasterEaNoMatch.new(row.to_hash)
      if batch.size >= batch_size
        MasterEaNoMatch.import batch
          batch = []
    end
  end
    MasterEaNoMatch.import batch
  end

  def self.to_csv # Export to csv function
    attributes = %w{list uid lname search_date}
    CSV.generate(headers: true) do |csv|
      csv << attributes

        all.each do |master_ea_match|
          csv << attributes.map{ |attr| master_ea_match.send(attr) }
        end
    end
  end
end
