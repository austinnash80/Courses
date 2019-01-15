class CpeDueDate < ApplicationRecord
  require 'csv'

  def self.import(file) # import to cvs function
    CSV.foreach(file.path, headers: true, header_converters: :symbol) do |row|
    CpeDueDate.create! row.to_hash
    end
  end

end
