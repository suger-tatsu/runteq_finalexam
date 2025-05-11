class GroupStudent < ApplicationRecord
  belongs_to :student
  belongs_to :group
end
