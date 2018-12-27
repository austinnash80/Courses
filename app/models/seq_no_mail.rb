class SeqNoMail < ApplicationRecord

  def self.to_csv # Export to csv function
    attributes = %w{ remove first_name mi last_name suf co address address_2 city state zip date_added}
    CSV.generate(headers: true) do |csv|
      csv << attributes

        all.each do |seq_no_mail|
          csv << attributes.map{ |attr| seq_no_mail.send(attr) }
        end
    end
  end

  def self.import(file) # import to cvs function
    CSV.foreach(file.path, headers: true, header_converters: :symbol, :encoding => 'utf-8') do |row|
    SeqNoMail.create! row.to_hash
  end
end

end
