class SeqNoMail < ApplicationRecord
  # self.primary_key = 'zip'

  def self.to_csv # Export to csv function
    attributes = %w{first_name mi last_name suf co address address_2 city state zip date_added extra_i extra_b extra_s}
    CSV.generate(headers: true) do |csv|
      csv << attributes

        all.each do |seq_no_mail|
          csv << attributes.map{ |attr| seq_no_mail.send(attr) }
        end
    end
  end

#   def self.import(file) # import to cvs function
#     CSV.foreach(file.path, headers: true) do |row|
#     SeqNoMail.create! row.to_hash
#   end
# end

end
