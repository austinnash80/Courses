class CourseCreationTask < ApplicationRecord
  belongs_to :empire_course
  belongs_to :course_creation_templete
end
