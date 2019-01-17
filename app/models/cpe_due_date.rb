class CpeDueDate < ApplicationRecord
  require 'csv'

  def self.to_csv # Export to csv function
    attributes = %w{state st quanity cpe_group renew_type cpe_due ss_allowed year_minimum exclude state_note partial_mail partial_number extra_s extra_b extra_i extra_d}
    CSV.generate(headers: true) do |csv|
      csv << attributes

        all.each do |cpe_due_date|
          csv << attributes.map{ |attr| cpe_due_date.send(attr) }
        end
    end
  end

  def self.import(file) # import to cvs function
    CSV.foreach(file.path, headers: true, header_converters: :symbol) do |row|
    CpeDueDate.create! row.to_hash
    end
  end

end
