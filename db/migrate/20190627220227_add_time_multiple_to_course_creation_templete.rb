class AddTimeMultipleToCourseCreationTemplete < ActiveRecord::Migration[5.1]
  def change
    add_column :course_creation_templetes, :time_multiple, :decimal
  end
end
