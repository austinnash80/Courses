class Copyright < ApplicationRecord
  belongs_to :datasheet, foreign_key: 'seq_number'
  default_scope { order( :seq_number) }

end
