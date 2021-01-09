class ApplicationController < ActionController::Base
  include SessionHelper

  private

  def require_login
    unless logged_in?
      flash[:danger] = 'ログインをしてください。'
      redirect_to login_path
    end
  end
end
