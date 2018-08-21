class AddTagToPesCourse < ActiveRecord::Migration[5.1]
  def change
    add_column :pes_courses, :tag, :string
  end
end
