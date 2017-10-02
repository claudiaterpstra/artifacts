class Lecture < ApplicationRecord
  belongs_to :course
  has_many :artworks, dependent: :destroy
  mount_uploader :video, VideoUploader
end
