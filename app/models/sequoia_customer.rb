class SequoiaCustomer < ApplicationRecord

  require 'csv'
  require 'activerecord-import/base'
  require 'activerecord-import/active_record/adapters/postgresql_adapter'
  # validates :unique_id, :presence => true, :uniqueness => true

  def self.my_import(file)
    sequoia_customers = []
    CSV.foreach(file.path, headers: true, header_converters: :symbol, :encoding => 'utf-8') do |row|
    sequoia_customers << SequoiaCustomer.new(row.to_hash)
    end
    SequoiaCustomer.import sequoia_customers, recursive: true
  end

end
