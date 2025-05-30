class TeachersController < ApplicationController
  before_action :set_current_teacher, only: [ :edit_password, :update_password, :edit_icon, :update_icon ]
  def new
    @teacher = Teacher.new
  end

  def create
    @teacher = Teacher.new(teacher_params)  # フォームからのパラメータを使って新しい教師を作成
    if @teacher.save
      flash[:success] = "登録が完了しました。ログインしてください。"
      session[:user_id] = @teacher.id  # ユーザーIDをセッションに保存
      redirect_to login_path  # ログインページにリダイレクト
    else
      # エラーハンドリング
      render partial: "form", locals: { teacher: @teacher }, status: :unprocessable_entity
    end
  end

  def edit_password
  end

  def update_password
    if @current_teacher.authenticate(params[:teacher][:current_password])
      if @current_teacher.update(password_params)
        redirect_to students_path, notice: "パスワードを変更しました"
      else
        flash.now[:alert] = @current_teacher.errors.full_messages.join(", ")
        render :edit_password
      end
    else
      flash.now[:alert] = "現在のパスワードが正しくありません"
      render :edit_password
    end
  end

  def edit_icon
  end

  def update_icon
    if @current_teacher.update(icon_params)
      redirect_to students_path, notice: "アイコンを変更しました"
    else
      Rails.logger.error "アイコン変更失敗: #{@current_teacher.errors.full_messages}"
      @current_teacher.reload # アップロード失敗時に未保存状態をリセット
      flash.now[:alert] = @current_teacher.errors.full_messages.join(", ")
      render :edit_icon
    end
  end

  private

  def teacher_params
    params.require(:teacher).permit(:name, :email, :password, :password_confirmation)
  end

  def set_current_teacher
    @current_teacher = Teacher.find(session[:teacher_id])
    unless @current_teacher
      redirect_to login_path, alert: "ログインしてください"
    end
  end

  def password_params
    params.require(:teacher).permit(:password, :password_confirmation)
  end

  def icon_params
    params.require(:teacher).permit(:icon)
  end
end
