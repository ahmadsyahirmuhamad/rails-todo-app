class User < ActiveRecord::Base

  has_secure_password(validations: false)

  has_many :todos

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :first_name, presence: true, on: :update
  validates :last_name, presence: true, on: :update
  validates :email, presence: true,
              uniqueness: true,
              length: { maximum: 255 },
              format: { with: VALID_EMAIL_REGEX }


  def generate_auth_token
    payload = { user_id: id }
    AuthTokenServices.encode(payload)
  end
end
