class Group < ApplicationRecord
  belongs_to :group_assignment
  has_many :group_students, dependent: :destroy
  has_many :group_skills
  has_many :group_assignment_students, dependent: :destroy
  # has_many :students, through: :group_students
  has_many :students, through: :group_assignment_students
end
