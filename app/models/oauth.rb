require 'net/https'
require 'uri'
require 'json'

class Oauth
  HOST = "https://arcane-ravine-29792.herokuapp.com"
  CLIENT_ID = '4085b0c5599cd4c1980dacc911286fdc940da3717c0d97eea5df5d4aa47fbae3'
  CLIENT_SECRET = '1dd35ab5fabf24c39339ab250a3db178f569a24573ea408b0b7660cbddb9f20d'
  REDIRECT_URL = 'http://localhost:3000/oauth/callback'
  AUTHORIZE_PARAMS = "response_type=code&client_id=#{CLIENT_ID}&redirect_uri=#{REDIRECT_URL}"
  AUTHORIZE_URL = "#{HOST}/oauth/authorize?#{AUTHORIZE_PARAMS}"
  GET_TOKEN_URL = "#{HOST}/oauth/token"
  TWEET_URL = "#{HOST}/api/tweets"

  class << self
    def authorize_url
      AUTHORIZE_URL
    end

    def get_access_token(code)
      uri = URI.parse(GET_TOKEN_URL)
      response = Net::HTTP.post_form(uri, post_params(code))

      JSON.parse(response.body)['access_token']
    end

    def post_tweet(title, image_url, token)
      uri = URI.parse(TWEET_URL)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      req = Net::HTTP::Post.new(uri.request_uri)
      req["Authorization"] = "bearer #{token}"
      req["Content-Type"] = "application/json"
      req.body = { text: title, url: image_url }.to_json
      res = http.request(req)

      return res.code
    end

    private

    def post_params(code)
      {
        code: code,
        client_id: CLIENT_ID,
        client_secret: CLIENT_SECRET,
        redirect_uri: REDIRECT_URL,
        grant_type: 'authorization_code'
      }
    end
  end
end

