class ApplicationController < ActionController::Base
  include SessionsHelper
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

   helper_method :current_teacher

  def current_teacher
    @current_teacher ||= Teacher.find_by(id: session[:teacher_id])
  end

  def authenticate_teacher!
    unless current_teacher
      flash[:alert] = "ログインしてください"
      redirect_to login_path
    end
  end
end
