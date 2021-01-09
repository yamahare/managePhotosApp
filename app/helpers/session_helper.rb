module SessionHelper

  def login(user)
    session[:user_id] = user.id
    current_user
  end

  def current_user
    # sessionからuserを取得
    if user_id = session[:user_id]
      @current_user ||= User.find_by(id: user_id)
    end
  end

  def logged_in?
    !current_user.nil?
  end

  def logout
    session.delete(:user_id)
    @current_user = nil
  end

  def my_tweet_app_connected?
    session[:my_tweet_app_token].present?
  end
end

