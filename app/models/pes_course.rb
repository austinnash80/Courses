class PesCourse < ApplicationRecord
  self.primary_key = 'pes_number'
  has_one :datasheet
  validates :pes_number, :presence => true, :uniqueness => true

end
