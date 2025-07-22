class GroupAssignmentForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attr_reader :teacher, :group_assignment

  attribute :title, :string
  attribute :group_count, :integer
  attribute :strategy, :string
  attribute :student_ids, default: []
  attribute :skill_ids, default: []
  attribute :ability_selection, default: []
  attribute :ability_weights, default: {}
  attribute :public_enabled, :boolean
  attribute :public_password, :string

  validates :title, :group_count, :strategy, presence: true
  validates :group_count, numericality: { greater_than: 0 }

  delegate :skill_ids, to: :group_assignment

  def initialize(attributes = {}, group_assignment: nil, teacher:)
    @teacher = teacher
    @group_assignment = group_assignment || teacher.group_assignments.build
    attributes = default_attributes if attributes.blank?
    super(attributes)
  end

  def save
    return false unless valid?

    group_assignment.title = title
    group_assignment.group_count = group_count
    group_assignment.strategy = strategy
    group_assignment.teacher = teacher
    group_assignment.selected_student_ids = student_ids.reject(&:blank?)
    group_assignment.ability_selection = ability_selection
    group_assignment.ability_weights = ability_weights.reject { |_, v| v.blank? }

    group_assignment.save_and_assign_groups
  end

  private

  def default_attributes
    {
      title: group_assignment.title,
      group_count: group_assignment.group_count,
      strategy: group_assignment.strategy,
      student_ids: group_assignment.selected_student_ids,
      ability_selection: group_assignment.ability_selection,
      ability_weights: group_assignment.ability_weights
    }
  end
end
