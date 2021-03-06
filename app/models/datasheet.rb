class Datasheet < ApplicationRecord
  self.primary_key = 'seq_number'
  has_many :Updatesheets
  has_many :CourseComments
  has_one :Copyrights
  belongs_to :pes_course, foreign_key: 'pes_number'
  validates :seq_number, :presence => true, :uniqueness => true

  def self.to_csv # Export to csv function
    attributes = %w{seq_number seq_version category seq_title hours pub_date seq_update seq_original_list active drop_date drop_reason pes_listed pes_number pes_version needs_approval has_approval approval_info course_note extra_note}
    CSV.generate(headers: true) do |csv|
      csv << attributes

        all.each do |datasheet|
          csv << attributes.map{ |attr| datasheet.send(attr) }
        end
    end
  end

  def self.import(file) # import to cvs function
    CSV.foreach(file.path, headers: true) do |row|
    Datasheet.create! row.to_hash
  end
end


end
