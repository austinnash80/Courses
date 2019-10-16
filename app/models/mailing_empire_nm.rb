class MailingEmpireNm < ApplicationRecord

  # require 'csv'

  def self.to_csv # Export to csv function
    attributes = %w{list license_no first middle last add1 add2 city state zipcode email}
    CSV.generate(headers: true) do |csv|
      csv << attributes

        all.each do |nm|
          csv << attributes.map{ |attr| nm.send(attr) }
        end
    end
  end

  def self.import(file) # import to cvs function
      CSV.foreach(file.path, headers: true) do |row|
      MailingEmpireNm.create! row.to_hash
    end
  end

  # def self.import(file)
  #   batch,batch_size = [], 1_000
  #   CSV.foreach(file.path, headers: true, header_converters: :symbol, :encoding => 'utf-8') do |row|
  #     batch << MailingEmpireNm.new(row.to_hash)
  #     if batch.size >= batch_size
  #       MailingEmpireNm.import batch
  #         batch = []
  #   end
  # end
  #   MailingEmpireNm.import batch
  # end

end
