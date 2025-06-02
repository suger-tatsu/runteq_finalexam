class Public::GroupAssignmentsController < ApplicationController
  layout "public"

  def show
    @group_assignment = GroupAssignment.find_by!(public_token: params[:token])


    if !@group_assignment.public_enabled
      render plain: "このグループ分けは現在非公開です", status: :forbidden and return
    end

    if @group_assignment.public_password_digest.present? &&
       !session.dig(:authorized_tokens)&.include?(@group_assignment.public_token)
      redirect_to public_password_group_assignment_path(token: @group_assignment.public_token)
    end

    @groups = @group_assignment.groups.includes(:students)
  end

  def password
    @group_assignment = GroupAssignment.find_by!(public_token: params[:token])
  end

  def verify_password
    @group_assignment = GroupAssignment.find_by!(public_token: params[:token])

    if @group_assignment.authenticate_public_password(params[:password])
      session[:authorized_tokens] ||= []
      session[:authorized_tokens] << @group_assignment.public_token
      redirect_to public_group_assignment_path(token: @group_assignment.public_token)
    else
      flash.now[:alert] = "パスワードが違います"
      render :password, status: :unprocessable_entity
    end
  end
end
