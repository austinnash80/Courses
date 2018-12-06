class CourseComment < ApplicationRecord
  # self.primary_key = 'course_number'
  belongs_to :Datasheet, foreign_key: 'course_number'
end
