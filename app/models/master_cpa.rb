class MasterCpa < ApplicationRecord
  validates :lid, presence: true, uniqueness: true

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

  def self.to_csv # Export to csv function
    attributes = %w{lid list lname no_mail_date}
    CSV.generate(headers: true) do |csv|
      csv << attributes
        all.each do |master_cpa_match|
          csv << attributes.map{ |attr| master_cpa_match.send(attr) }
        end
    end
  end



end
