class SessionsController < ApplicationController
  #Modelの作成（=テーブルに新たなレコードの作成）は無いので特にnewアクションは無し
  def new
  end

  def create #ログイン時のアクション
    email = params[:session][:email].downcase
    password = params[:session][:password]
    if login(email, password)
      flash[:success] = 'ログインに成功しました。'
      #toppage(tasks#index)へ
      redirect_to root_url
    else
      flash.now[:danger] = 'ログインに失敗しました。'
      #(sessions#new)へ
      render :new
    end
  end

  def destroy #ログアウト時のアクション
    session[:user_id] = nil
    flash[:success] = 'ログアウトしました。'
    redirect_to root_url
  end

  private

  def login(email, password)
    @user = User.find_by(email: email)
    if @user && @user.authenticate(password)
      # ログイン成功
      session[:user_id] = @user.id
      return true
    else
      # ログイン失敗
      return false
    end
  end
end
