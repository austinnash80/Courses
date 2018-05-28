class Updatesheet < ApplicationRecord
  belongs_to :datasheet
  default_scope { order({date_received: :desc}, :seq_number) }
end
