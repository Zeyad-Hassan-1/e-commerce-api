class User < ApplicationRecord
  before_create :set_confirmation_token
  has_secure_password

  validates :username, uniqueness: true
  has_many :reviews, dependent: :destroy
  has_many :favourites, dependent: :destroy
  has_many :favourite_products, through: :favourites, source: :product
  has_one :cart
  has_many :orders

  # Generates a secure token and sets timestamp
  def generate_password_reset_token!
    self.reset_password_token = SecureRandom.hex(10)
    self.reset_password_sent_at = Time.current
    save!
  end

  # Valid for 1 hour
  def password_token_valid?
    reset_password_sent_at && reset_password_sent_at >= 1.hour.ago
  end

  # Reset the password and clear token fields
  def reset_password!(new_password)
    self.password = new_password
    self.reset_password_token = nil
    self.reset_password_sent_at = nil
    save!
  end

  def confirm_email!
    update!(
      confirmation_token: nil,
      confirmed_at: Time.current,
      email_confirmed: true
    )
  end


  def email_confirmed?
    confirmed_at.present?
  end

  private
   def set_confirmation_token
     self.confirmation_token = SecureRandom.urlsafe_base64(24)
     self.confirmation_sent_at = Time.current
   end
end
