module SessionsHelper
  def log_in(teacher)
    session[:teacher_id] = teacher.id
  end

  def remember(teacher)
    teacher.remember
    cookies.permanent.signed[:teacher_id] = teacher.id
    cookies.permanent[:remember_token] = teacher.remember_token
  end

  def forget(teacher)
    teacher.forget
    cookies.delete(:teacher_id)
    cookies.delete(:remember_token)
  end

  def current_teacher
    if (teacher_id = session[:teacher_id])
      @current_teacher ||= Teacher.find_by(id: teacher_id)
    elsif (teacher_id = cookies.signed[:teacher_id])
      teacher = Teacher.find_by(id: teacher_id)
      if teacher&.authenticated?(:remember, cookies[:remember_token])
        log_in(teacher)
        @current_teacher = teacher
      end
    end
  end

  def logged_in?
    !current_teacher.nil?
  end

  def log_out
    current_teacher.forget
    cookies.delete(:teacher_id)
    cookies.delete(:remember_token)
    session.delete(:teacher_id)
    @current_teacher = nil
  end
end
