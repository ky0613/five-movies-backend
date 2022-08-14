class Post < ApplicationRecord
  mount_uploader :image, PostImageUploader
  has_many :movies, dependent: :destroy
end
