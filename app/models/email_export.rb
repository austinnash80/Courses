class EmailExport < ApplicationRecord
  def self.to_csv # Export to csv function
    attributes = %w{send_email company subject merge_1 merge_2 merge_3 merge_4 merge_5 f_name l_name email}
    CSV.generate(headers: true) do |csv|
      csv << attributes

        all.each do |email_export|
          csv << attributes.map{ |attr| email_export.send(attr) }
        end
    end
  end #END DEF
end
