class EmpireMasterList < ApplicationRecord

  def self.my_import(file)
    batch,batch_size = [], 1_000
    CSV.foreach(file.path, headers: true, header_converters: :symbol, :encoding => 'iso-8859-1:utf-8') do |row|
      batch << EmpireMasterList.new(row.to_hash)
      if batch.size >= batch_size
        EmpireMasterList.import batch
          batch = []
    end
  end
    EmpireMasterList.import batch
  end

  def self.to_csv # Export to csv function
    attributes = %w{lid list source license_number record_type lic_status iss_date_s iss_date exp_date_s expe_date first_name mi last_name company address_1 address_2 city state zip county extra_d extra_s extra_b created_at exp_date email}
    CSV.generate(headers: true) do |csv|
      csv << attributes

        all.each do |empire_master_list|
          csv << attributes.map{ |attr| empire_master_list.send(attr) }
        end
    end
  end

end
