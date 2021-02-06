class EmpireMasterNoMatch < ApplicationRecord
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
