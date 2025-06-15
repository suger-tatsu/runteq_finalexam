class SessionsController < ApplicationController
  include SessionsHelper

  def new
    redirect_to students_path if logged_in?
  end

  def create
    teacher = Teacher.find_by(email: params[:session][:email].to_s.downcase)
    if teacher&.authenticate(params[:session][:password])
      log_in teacher
      if params[:session][:remember_me] == "1"
        remember(teacher)
      else
        forget(teacher)
      end
      redirect_to students_path, notice: "ログインしました"
    else
      flash.now[:alert] = "メールアドレスまたはパスワードが無効です"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    log_out
    redirect_to root_path, notice: "ログアウトしました"
  end
end
