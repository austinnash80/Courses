class Task < ApplicationRecord
    # belongs_to :user
    has_attached_file :task_doc_1,
                            :url =>':s3_domain_url',
                            :path => "/:basename.:extension"
    has_attached_file :task_doc_2,
                            :url =>':s3_domain_url',
                            :path => "/:basename.:extension"

    validates_attachment :task_doc_1, :content_type => {:content_type => %w(image/jpeg image/jpg image/png application/pdf application/msword application/vnd.openxmlformats-officedocument.wordprocessingml.document application/vnd.openxmlformats-officedocument.spreadsheetml.sheet)}
    validates_attachment :task_doc_2, :content_type => {:content_type => %w(image/jpeg image/jpg image/png application/pdf application/msword application/vnd.openxmlformats-officedocument.wordprocessingml.document application/vnd.openxmlformats-officedocument.spreadsheetml.sheet)}

end
