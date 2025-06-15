class Teacher < ApplicationRecord
  has_secure_password
  has_one_attached :icon

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }, if: :password_required?

  def password_required?
    new_record? || password.present?
  end

  has_many :students, dependent: :destroy
  has_many :skills, dependent: :destroy
  has_many :group_assignments, dependent: :destroy

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = Teacher.new_token
    update(remember_digest: BCrypt::Password.create(remember_token))
  end

  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.blank? || token.blank?
    BCrypt::Password.new(digest).is_password?(token)
  rescue BCrypt::Errors::InvalidHash
    false
  end

  attr_accessor :remember_token

  def forget
    update(remember_digest: nil)
  end
end
