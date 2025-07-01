class SessionsController < ApplicationController
  include SessionsHelper

  def new
    redirect_to students_path if logged_in?
  end

  def omniauth
    auth = request.env["omniauth.auth"]
    teacher = Teacher.find_or_initialize_by(email: auth.info.email)

    if teacher.new_record?
      teacher.name = auth.info.name
      teacher.password = SecureRandom.hex(10)
      teacher.save!
    end

    session[:teacher_id] = teacher.id
    redirect_to students_path, notice: "#{teacher.name}としてログインしました"
  end

  def create
    teacher = Teacher.find_by(email: params[:session][:email].to_s.downcase)
    if teacher&.authenticate(params[:session][:password])
      reset_session
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
