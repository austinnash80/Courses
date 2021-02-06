class EmpireMasterMatch < ApplicationRecord
  def self.to_csv # Export to csv function
    attributes = %w{uid last_name lid list source search_date}
    CSV.generate(headers: true) do |csv|
      csv << attributes

        all.each do |empire_master_list|
          csv << attributes.map{ |attr| empire_master_list.send(attr) }
        end
    end
  end
end
