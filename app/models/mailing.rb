class Mailing < ApplicationRecord

  has_attached_file :msi_art,
                      :url =>':s3_domain_url', # Upload to AWS folder, having permission issues
                      :path => "/:basename.:extension"

  # Validate the attached image is image/jpg, image/png, etc
  validates_attachment_content_type :msi_art, :content_type => /\Aimage\/.*\Z/
  # validates_attachment :msi_art, :content_type => {:content_type => %w(image/jpeg image/jpg image/png application/pdf application/msword application/vnd.openxmlformats-officedocument.wordprocessingml.document application/vnd.openxmlformats-officedocument.spreadsheetml.sheet)}
end
