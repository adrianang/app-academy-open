class User < ApplicationRecord
  attr_reader :password

  validates :user_name, :password_digest, presence: true
  validates :session_token, presence: { message: 'Password can\'t be blank' }
  validates :password, length: { minimum: 6 }, allow_nil: true

  after_validation :ensure_session_token

  def self.find_by_credentials(user_name, password)
    user = self.class.find_by(user_name: user_name)
    return nil if user.nil?
    user.is_password?(password) ? user : nil
  end

  def self.generate_session_token
    SecureRandom::urlsafe_base64(16)
  end

  def reset_session_token!
    self.session_token = self.class.generate_session_token
    self.save!
    self.session_token
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password) 
  end

  private
  def ensure_session_token
    self.session_token ||= self.class.generate_session_token
  end
end
