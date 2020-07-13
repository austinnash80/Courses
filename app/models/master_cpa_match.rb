class MasterCpaMatch < ApplicationRecord

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
