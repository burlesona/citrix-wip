require 'bcrypt'

class User < ActiveRecord::Base
  attr_accessor :password

  # Validations
  validates_presence_of :first_name, :last_name, :email, :username
  validates_uniqueness_of :email, :username
  validates :password, length: {minimum: 6}, confirmation: true, allow_blank: true

  # Callbacks
  before_save :set_password

  def password_matches?(string)
    password_hash.present? &&
    string.is_a?(String) &&
    BCrypt::Password.new(password_hash) == string
  end

  private
  def set_password
    self.password_hash = BCrypt::Password.create(password) if password.present?
  end
end
