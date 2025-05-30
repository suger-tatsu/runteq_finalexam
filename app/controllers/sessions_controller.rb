class SessionsController < ApplicationController
  def new
  end

  def create
    teacher = Teacher.find_by(email: params[:email])
    if teacher && teacher.authenticate(params[:password])
      session[:teacher_id] = teacher.id
      redirect_to students_path, notice: "ログイン成功"
    else
      flash.now[:alert] = "メールアドレスまたはパスワードが違います"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session[:teacher_id] = nil # セッションのクリア
    redirect_to login_path, notice: "ログアウトしました"
  end
end
