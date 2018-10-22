class ExamResult < ApplicationRecord

  def self.my_import(file)
    batch,batch_size = [], 1_000
    CSV.foreach(file.path, headers: true, header_converters: :symbol, :encoding => 'utf-8') do |row|
      batch << ExamResult.new(row.to_hash)
      if batch.size >= batch_size
        ExamResult.import batch
          batch = []
    end
  end
  ExamResult.import batch
  end

end
