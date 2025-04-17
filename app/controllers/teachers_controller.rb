class TeachersController < ApplicationController
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
      render :new  # エラーがあった場合、新規登録フォームを再表示
    end
  end

  private

  def teacher_params
    params.require(:teacher).permit(:name, :email, :password, :password_confirmation)
  end
end
