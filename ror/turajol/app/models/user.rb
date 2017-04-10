class User < ApplicationRecord
  PHONE_FORMAT = /\A\d{9}\z/
  MESSAGE_ERORR_FORMAT = I18n.t(:phone_format_error)

  validates :phone, presence: true, format: {with: PHONE_FORMAT, message: MESSAGE_ERORR_FORMAT}

  before_create :set_verification_code

  def confirm_phone(verification_code)
    if self.verification_code == verification_code
      self.code_confirmed_at = Time.now
      set_token
      save
    end
  end

  private
  def set_verification_code
    return if verification_code.present?
    self.verification_code = generate_verification_code
  end

  def generate_verification_code
    '%04d' % SecureRandom.random_number(10000)
  end

  def set_token
    self.token = generate_auth_token
    five_years = 60 * 60 * 24 * 5
    self.token_expired_at = Time.now + five_years
  end

  def generate_auth_token
    SecureRandom.uuid.gsub(/\-/, '')
  end
end
