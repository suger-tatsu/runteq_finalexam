class GroupsController < ApplicationController
    def new
    @group_assignment = GroupAssignment.find(params[:group_assignment_id])
    @group = @group_assignment.groups.new
    @students = Student.all
  end

  def create
    @group_assignment = GroupAssignment.find(params[:group_assignment_id])
    @group = @group_assignment.groups.new(group_params)

    if @group.save
      if params[:group][:student_ids]
        params[:group][:student_ids].each do |student_id|
          student = Student.find(student_id)
          @group.students << student
        end
      end
      redirect_to group_assignment_path(@group_assignment), notice: "グループを作成しました"
    else
      flash.now[:alert] = "グループ作成に失敗しました"
      render :new
    end
  end

  private

  def group_params
    params.require(:group).permit(:name)
  end
end
