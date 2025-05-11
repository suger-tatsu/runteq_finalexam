class Group < ApplicationRecord
  belongs_to :group_assignment
  has_many :group_students
  has_many :group_skills
  has_many :students, through: :group_students
end
