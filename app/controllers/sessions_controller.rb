class SessionsController < ApplicationController

  before_action :require_login, only: %i[destroy]

  def new
    @session = LoginForm.new
  end

  def create
    @session = LoginForm.new(params)
    if user = @session.login_enable?
      login(user)
      flash[:success] = 'やったーログインしました'
      redirect_to root_url
    else
      flash.now[:danger] = 'ログイン情報を確認してください'
      render :new
    end
  end

  def destroy
    logout if logged_in?
    redirect_to root_url
  end

end
