class Student < ApplicationRecord
  belongs_to :teacher
  has_many :student_skills
  has_many :skills, through: :student_skills
  has_many :group_assignment_students
  has_many :group_assignments, through: :group_assignment_students
  has_many :group_students
  has_many :groups, through: :group_students

  validates :name, presence: true
  validates :gender, inclusion: { in: %w(男 女) }
  validates :height, numericality: { allow_nil: true }
  validates :weight, numericality: { allow_nil: true }
  validates :athletic_ability, inclusion: { in: 0..10 }
  validates :leadership, inclusion: { in: 0..10 }
  validates :cooperation, inclusion: { in: 0..10 }
  validates :science, inclusion: { in: 0..10 }
  validates :humanities, inclusion: { in: 0..10 }
end
