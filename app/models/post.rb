class Post < ApplicationRecord
  mount_uploader :image, PostImageUploader
  has_many :movies, dependent: :destroy

  validates :uuid, :image, presence: true
  validates :name, presence: true, length: {maximum: 10}

end
