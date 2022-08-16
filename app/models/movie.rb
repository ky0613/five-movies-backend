class Movie < ApplicationRecord
  belongs_to :post
  validates :movie_id, presence: true
end
