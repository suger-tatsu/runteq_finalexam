class GroupAssignment < ApplicationRecord
  belongs_to :teacher
  has_many :groups, dependent: :destroy
  has_many :group_assignment_students, dependent: :destroy
  has_many :students, through: :group_assignment_students

  validates :title, presence: true

  attr_accessor :strategy, :selected_student_ids, :skill_ids, :ability_weights

  after_initialize :set_defaults, if: :new_record?

  def set_defaults
    self.ability_selection ||= []
    self.ability_weights ||= {}
  end

  def self.new_from_params(params, teacher)
    student_ids = params[:student_ids] || []
    selected_abilities = params[:ability_selection] || []
    selected_skill_ids = params[:skill_ids]&.reject(&:blank?)&.map(&:to_i) || []
    weights = (params[:ability_weights] || {}).transform_values(&:to_i)

    new(
      title: params[:title],
      teacher: teacher,
      ability_selection: selected_abilities,
      group_count: params[:group_count]
    ).tap do |assignment|
      assignment.strategy = params[:strategy]
      assignment.selected_student_ids = student_ids.map(&:to_i)
      assignment.skill_ids = selected_skill_ids
      assignment.ability_weights = weights
    end
  end

  def save_and_assign_groups
    return false unless valid? && ability_selection.present?

    if save
      strategy == "even" ? assign_students_evenly : assign_students_to_groups
      true
    else
      false
    end
  end

  def assign_students_to_groups
    distribute_students(order: :desc)
  end

  def assign_students_evenly
    distribute_students(order: :desc, zigzag: true)
  end

  private

  def distribute_students(order:, zigzag: false)
    students = Student.where(id: selected_student_ids)
    return if students.empty? || group_count.to_i < 1

    student_data = students.map do |student|
      score = ability_selection.sum do |ability|
        weight = ability_weights[ability].to_i
        student.send(ability).to_i * weight
      end

      matched_skills = skill_ids.present? ? student.skills.pluck(:id) & skill_ids : []
      [ student, score, matched_skills ]
    end

    student_data.sort_by! do |_, score, skills|
      [ -(skills.size), order == :desc ? -score : score ]
    end

    buckets = Array.new(group_count.to_i) { [] }
    forward = true
    until student_data.empty?
      (0...group_count.to_i).each do |i|
        idx = zigzag ? (forward ? i : group_count.to_i - 1 - i) : i
        buckets[idx] << student_data.shift if student_data.any?
      end
      forward = !forward if zigzag
    end

    buckets.each_with_index do |members, i|
      group = groups.create!(name: "#{i + 1}班")
      members.each do |(student, _, _)|
        GroupAssignmentStudent.create!(group_assignment: self, group: group, student: student)
      end
    end
  end
end
