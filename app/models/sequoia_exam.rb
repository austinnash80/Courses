class SequoiaExam < ApplicationRecord

  require 'csv'
  require 'activerecord-import/base'
  require 'activerecord-import/active_record/adapters/postgresql_adapter'
  # validates :unique_id, :presence => true, :uniqueness => true

  def self.my_import(file)
    batch,batch_size = [], 1_000
    CSV.foreach(file.path, headers: true, header_converters: :symbol, :encoding => 'utf-8') do |row|
      batch << SequoiaExam.new(row.to_hash)
      if batch.size >= batch_size
        SequoiaExam.import batch
          batch = []
    end
  end
  SequoiaExam.import batch

end
end
