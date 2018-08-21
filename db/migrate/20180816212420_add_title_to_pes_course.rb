class AddTitleToPesCourse < ActiveRecord::Migration[5.1]
  def change
    add_column :pes_courses, :title, :string
  end
end
