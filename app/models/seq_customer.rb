class SeqCustomer < ApplicationRecord
  self.primary_key = 'uid'
  has_many :postcard_returns

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
    SeqCustomer.create! row.to_hash
    end
  end

end
