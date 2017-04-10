class Point < ApplicationRecord
  FORMAT_COORDINATES = /\A[\d]{2}[\.][\d]*\z/
  MESSAGE_ERORR_FORMAT = I18n.t(:point_format_error)

  validates :latitude, presence: true
  validates :longitude, presence: true

  validates :latitude, format: {with: FORMAT_COORDINATES, message: MESSAGE_ERORR_FORMAT}
  validates :longitude, format: {with: FORMAT_COORDINATES, message: MESSAGE_ERORR_FORMAT}

  scope :active, -> { where(deleted_at: nil) }

  def increase_counter
    self[:counter] += 1 if self[:deleted_at].nil?
  end
end
