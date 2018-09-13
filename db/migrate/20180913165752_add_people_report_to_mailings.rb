class AddPeopleReportToMailings < ActiveRecord::Migration[5.1]
  def self.up
      add_attachment :mailings, :people_report
    end

  def self.down
    remove_attachment :mailings, :people_report
  end
end
