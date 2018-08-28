class SeqCustomer < ApplicationRecord
  # self.primary_key = 'uid'
  has_many :postcard_returns
  # validates_uniqueness_of :order_id
  # validates :order_id, :presence => true, :uniqueness => true


  require 'csv'
  require 'activerecord-import/base'
  require 'activerecord-import/active_record/adapters/postgresql_adapter'
  validates :order_id, :presence => true, :uniqueness => true


  def self.my_import(file) #The new better way? - Not working
    sequoia_customers = []
    CSV.foreach(file.path, headers: true) do |row|
    sequoia_customers << SeqCustomer.new(row.to_hash)
    end
    SeqCustomer.import sequoia_customers, recursive: true
  end

  # def self.import(file)
  #   CSV.foreach(file.path, headers: true) do |row|
  #   SeqCustomer.create! row.to_hash
  #   validates_uniqueness_of :order_id
  #   end
  # end

end
