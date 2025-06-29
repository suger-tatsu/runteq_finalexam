class Skill < ApplicationRecord
  before_validation :strip_name_whitespace
  belongs_to :teacher
  has_many :student_skills, dependent: :destroy
  has_many :students, through: :student_skills

  validates :name, presence: true, uniqueness: { scope: :teacher_id, message: "はすでに登録されています" }

  private

  def strip_name_whitespace
    self.name = name.strip if name.present?
  end
end
