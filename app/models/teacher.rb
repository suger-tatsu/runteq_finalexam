class Teacher < ApplicationRecord
  has_secure_password

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }

  has_many :students, dependent: :destroy
  has_many :skills, dependent: :destroy
  has_many :group_assignments, dependent: :destroy
end
