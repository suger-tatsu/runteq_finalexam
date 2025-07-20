class StudentForm
  include ActiveModel::Model
  include ActiveModel::Attributes
  extend ActiveModel::Naming
  include ActiveModel::Conversion

  attr_accessor :student, :teacher

  delegate :id, :persisted?, :to_key, to: :student, allow_nil: true

  attribute :name, :string
  attribute :gender, :string
  attribute :height, :float
  attribute :weight, :float
  attribute :athletic_ability, :integer
  attribute :leadership, :integer
  attribute :cooperation, :integer
  attribute :science, :integer
  attribute :humanities, :integer

  validates :name, presence: true
  validates :gender, inclusion: { in: %w[男 女] }
  validates :height, numericality: { greater_than: 0 }, allow_nil: true
  validates :weight, numericality: { greater_than: 0 }, allow_nil: true
  validates :athletic_ability, :leadership, :cooperation, :science, :humanities,
            inclusion: { in: 0..10 }

  def initialize(attributes = {}, student: nil, teacher:)
    @student = student || Student.new
    @teacher = teacher
    
    permitted_attributes = %i[
      name gender height weight
      athletic_ability leadership cooperation
      science humanities
    ]

    super((attributes.presence || @student.attributes.symbolize_keys).slice(*permitted_attributes))
  end

  def save
    return false unless valid?

    student.assign_attributes(
      name:,
      gender:,
      height:,
      weight:,
      athletic_ability:,
      leadership:,
      cooperation:,
      science:,
      humanities:,
      teacher: teacher
    )

    student.save
  end

  def update
    return false unless valid?

    student.update(
      name:,
      gender:,
      height:,
      weight:,
      athletic_ability:,
      leadership:,
      cooperation:,
      science:,
      humanities:
    )
  end
end
