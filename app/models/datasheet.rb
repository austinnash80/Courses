class Datasheet < ApplicationRecord
  has_many :Updatesheets

  def self.to_csv # Export to csv function
    attributes = %w{seq_number seq_version category seq_title hours pub_date seq_update seq_original_list active drop_date drop_reason pes_listed pes_number pes_version needs_approval has_approval approval_info course_note extra_note}
    CSV.generate(headers: true) do |csv|
      csv << attributes

        all.each do |datasheet|
          csv << attributes.map{ |attr| datasheet.send(attr) }
        end
    end
  end

  def self.import(file) # inport to cvs function
    CSV.foreach(file.path, headers: true) do |row|
    Datasheet.create! row.to_hash
  end
end
end
