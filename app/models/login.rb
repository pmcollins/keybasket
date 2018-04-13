require 'digest/sha1'
class Login < ActiveRecord::Base
  has_one :manager
  has_one :coordinator
  has_one :administrator

  has_many :user_sessions

  validates_presence_of     :name
  validates_uniqueness_of   :name

  validates_confirmation_of :password

  #TODO add length/regex constraints to name
  #TODO add length constraints to password

  def validate
    errors.add_to_base("Missing password") if hashed_password.blank?
  end

  def self.authenticate(name, password)
    login = self.find_by_name(name)
    if login
      expected_password = encrypt_password(password, login.salt)
      if login.hashed_password != expected_password
        login = nil
      end
    end
    login
  end

  # 'password' is a virtual attribute
  def password
    @password
  end

  def password_confirmation=(pwd)
    errors.add_to_base('Password mismatch') unless pwd == @password
  end

  def password=(pwd)
    @password = pwd
    create_new_salt
    self.hashed_password = Login.encrypt_password(
      self.password,
      self.salt
    )
  end

  def to_s
    name
  end

  def self.encrypt_password(password, salt)
    Digest::SHA1.hexdigest(password + 'shnibble' + salt)
  end

  private

  def create_new_salt
    self.salt = self.object_id.to_s + rand.to_s
  end

end
