class AddFieldsToPesCourses < ActiveRecord::Migration[5.1]
  def change
    add_column :pes_courses, :date_added, :date
    add_column :pes_courses, :date_removed, :date
    add_column :pes_courses, :extra_s, :string
    add_column :pes_courses, :extra_i, :integer
    add_column :pes_courses, :extra_b, :boolean
    add_column :pes_courses, :extra_d, :date
  end
end
