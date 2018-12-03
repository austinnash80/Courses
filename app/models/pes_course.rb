class PesCourse < ApplicationRecord
  self.primary_key = 'pes_number'
  has_many :datasheet
  validates :pes_number, :presence => true, :uniqueness => true

  def self.to_csv # Export to csv function
    attributes = %w{pes_number category hours active title tag date_added date_removed extra_s extra_i extra_b extra_d}
    CSV.generate(headers: true) do |csv|
      csv << attributes

        all.each do |pes_course|
          csv << attributes.map{ |attr| pes_course.send(attr) }
        end
    end
  end

end
