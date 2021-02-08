class MasterEaDoubleAccount < ApplicationRecord

  def self.to_csv # Export to csv function
    attributes = %w{uid uid2 lname lid list search_date}
    CSV.generate(headers: true) do |csv|
      csv << attributes

        all.each do |master_ea_double_account|
          csv << attributes.map{ |attr| master_ea_double_account.send(attr) }
        end
    end
  end

end
