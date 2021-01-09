class OauthController < ApplicationController

  before_action :require_login

  def tweet
    return unless session[:my_tweet_app_token]

    status_code = Oauth.post_tweet(tweet_params[:title],
                                   tweet_params[:image_url],
                                   session[:my_tweet_app_token])
    if status_code == '201'
      flash[:success] = "ツイートに成功しました。"
      redirect_to root_url
    else
      flash[:danger] = "ツイートに失敗しました。"
      redirect_to root_url
    end
  end

  def callback
    if session[:my_tweet_app_token] = Oauth.get_access_token(params['code'])
      flash[:success] = "MyTweetAppとの接続に成功しました。"
      redirect_to root_url
    else
      flash[:danger] = "MyTweetAppとの接続に失敗しました。"
      redirect_to root_url
    end
  end

  private

  def tweet_params
    params.fetch(:photo).permit(:title, :image_url)
  end

end
