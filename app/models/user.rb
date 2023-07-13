class User < ApplicationRecord

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def generate_jwt_token
    payload = { user_id: id, email: email }
    JWT.encode(payload, 'your_secret_key', 'HS256')
  end
end
