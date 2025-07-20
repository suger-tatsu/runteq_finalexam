class SkillForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attr_reader :skill, :teacher

  attribute :name, :string
  attribute :student_ids, default: []

  validates :name, presence: true

  def initialize(attributes = {}, skill: nil, teacher:)
    @teacher = teacher
    @skill = skill || teacher.skills.build
    attributes = default_attributes if attributes.blank?
    super(attributes)
  end

  def save
    return false unless valid?

    skill.name = name
    skill.student_ids = student_ids.reject(&:blank?)
    skill.save
  end

  def update
    save
  end

  private

  def default_attributes
    {
      name: skill.name,
      student_ids: skill.student_ids
    }
  end
end
