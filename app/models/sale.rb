class Sale < ApplicationRecord

  require 'csv'
  require 'activerecord-import/base'
  require 'activerecord-import/active_record/adapters/postgresql_adapter'

  def self.to_csv # Export to csv function
    attributes = %w{day sequoia empire pacific}
    CSV.generate(headers: true) do |csv|
      csv << attributes

        all.each do |sale|
          csv << attributes.map{ |attr| sale.send(attr) }
        end
    end
  end

  def self.my_import(file)
    batch,batch_size = [], 1_000
    CSV.foreach(file.path, headers: true, header_converters: :symbol, :encoding => 'utf-8') do |row|
      batch << Sale.new(row.to_hash)
      if batch.size >= batch_size
        Sale.import batch
          batch = []
    end
  end
    Sale.import batch
  end

end
