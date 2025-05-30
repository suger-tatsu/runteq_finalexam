class Skill < ApplicationRecord
  belongs_to :teacher
  has_many :student_skills
  has_many :students, through: :student_skills

  validates :name, presence: true, uniqueness: { scope: :teacher_id, message: "はすでに登録されています" }
end
