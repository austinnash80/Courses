class PostcardExport < ApplicationRecord

    def self.to_csv # Export to csv function
      attributes = %w{send_email company group send_date_s list license_number uid exp_s subject merge_1 merge_2 merge_3 merge_4 merge_5 f_name l_name add_1 add_2 city st zip email}
      CSV.generate(headers: true) do |csv|
        csv << attributes

          all.each do |postcard_export|
            csv << attributes.map{ |attr| postcard_export.send(attr) }
          end
      end
    end #END DEF

    # def self.to_csv # Export to csv function
    #   attributes = %w{company group mail_id mail_date state license_number uid g_id subject merge_1 merge_2 merge_3 merge_4 merge_5 f_name l_name add_1 add_2 city st zip email}
    #   CSV.generate(headers: true) do |csv|
    #     csv << attributes
    #
    #       all.each do |postcard_export|
    #         csv << attributes.map{ |attr| postcard_export.send(attr) }
    #       end
    #   end
    # end #END DEF

end # END CLASS
