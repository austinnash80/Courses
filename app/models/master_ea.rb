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

  def self.to_csv # Export to csv function
    attributes = %w{lid list lname no_mail_date}
    CSV.generate(headers: true) do |csv|
      csv << attributes
        all.each do |master_ea_no_mail|
          csv << attributes.map{ |attr| master_ea_no_mail.send(attr) }
        end
    end
  end
end
