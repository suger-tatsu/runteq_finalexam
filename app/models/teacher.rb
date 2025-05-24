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
end
