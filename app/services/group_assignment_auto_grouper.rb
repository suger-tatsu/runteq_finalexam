class GroupAssignmentAutoGrouper
  def initialize(group_assignment)
    @group_assignment = group_assignment
  end

  def execute
    if Rails.env.production?
      ApiBasedGrouper.new(@group_assignment).run
    else
      DockerBasedGrouper.new(@group_assignment).run
    end
  end
end