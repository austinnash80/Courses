class Updatesheet < ApplicationRecord
  belongs_to :datasheet, foreign_key: 'seq_number'
  default_scope { order({date_received: :desc}, :seq_number) }

end
