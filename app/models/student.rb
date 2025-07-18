class Student < ApplicationRecord
  belongs_to :teacher

  has_many :student_skills, dependent: :destroy
  has_many :skills, through: :student_skills

  has_many :group_assignment_students, dependent: :destroy
  has_many :group_assignments, through: :group_assignment_students

  has_many :group_students, dependent: :destroy
  has_many :groups, through: :group_students

  validates :name, presence: true, uniqueness: { scope: :teacher_id, message: "はすでに登録されています" }
  validates :gender, inclusion: { in: %w[男 女] }

  validates :height, numericality: { greater_than: 0, allow_nil: true }
  validates :weight, numericality: { greater_than: 0, allow_nil: true }

  validates :athletic_ability, inclusion: { in: 0..10 }
  validates :leadership, inclusion: { in: 0..10 }
  validates :cooperation, inclusion: { in: 0..10 }
  validates :science, inclusion: { in: 0..10 }
  validates :humanities, inclusion: { in: 0..10 }

  def self.ransackable_attributes(auth_object = nil)
    %w[
      name gender height weight
      athletic_ability leadership cooperation
      science humanities created_at updated_at
    ]
  end

  private

  def normalize_numerical_fields
    self.height = height.to_f if height.present?
    self.weight = weight.to_f if weight.present?
    %i[athletic_ability leadership cooperation science humanities].each do |attr|
      self[attr] = self[attr].to_i if self[attr].present?
    end
  end
end
