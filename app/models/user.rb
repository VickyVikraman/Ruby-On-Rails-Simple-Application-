class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  def self.valid_login?(email, password)
    user = where(email: email).first
    [user&.valid_password?(password), user]
  end

  def reset_authentication_token!
    update_column(:authentication_token, Devise.friendly_token)
  end
end
