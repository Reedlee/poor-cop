class Point < ApplicationRecord
  FORMAT_COORDINATES = /\A[\d]{2}[\.][\d]*\z/
  MESSAGE_ERORR_FORMAT = 'Only digital and point accepted'

  validates :latitude, presence: true
  validates :longitude, presence: true

  validates :latitude, format: {with: FORMAT_COORDINATES, message: MESSAGE_ERORR_FORMAT}
  validates :longitude, format: {with: FORMAT_COORDINATES, message: MESSAGE_ERORR_FORMAT}
end
