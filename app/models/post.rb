class Post < ApplicationRecord
  mount_uploader :image, PostImageUploader
  has_many :movies, dependent: :destroy

  validates :uuid,  presence: true, uniqueness: true
  validates :name, presence: true, length: {maximum: 10}
  validates :image, presence: true, on: :post_image_setup

end
