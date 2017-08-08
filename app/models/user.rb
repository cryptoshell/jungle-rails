class User < ActiveRecord::Base
  has_secure_password
  has_many :reviews

  validates :name, presence: true, length: {minimum: 1}
  validates :email, presence: true, uniqueness: {case_sensitive: false}, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
  validates :password, presence: true, confirmation: true, length: {minimum: 5}
  validates :password_confirmation, presence: true, length: {minimum: 5}

  def self.authenticate_with_credentials(email, password)
    @user = User.find_by(email: email.strip.downcase) 
    if @user && @user.authenticate(password)
      @user
    else
      nil
    end
  end
end
