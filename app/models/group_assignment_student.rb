class GroupAssignmentStudent < ApplicationRecord
  belongs_to :student
  belongs_to :group_assignment
  belongs_to :group
end
