class GroupAssignment < ApplicationRecord
  belongs_to :teacher
  has_many :groups, dependent: :destroy
  has_many :group_assignment_students
  has_many :students, through: :group_assignment_students
end
