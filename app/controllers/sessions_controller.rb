class SessionsController < ApplicationController
  def new
  end

  def create
    teacher = Teacher.find_by(email: params[:email])
    if teacher && teacher.authenticate(params[:password])
      session[:teacher_id] = teacher.id
      redirect_to root_path, notice: 'ログイン成功'
    else
      flash.now[:alert] = 'メールアドレスまたはパスワードが違います'
      render :new
    end
  end
end
