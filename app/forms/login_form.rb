class LoginForm
  include ActiveModel::Model
  include ActiveModel::Serialization
  include ActiveModel::Attributes
  extend ActiveModel::Translation

  attribute :userid, :string
  attribute :password, :string

  validates :userid, presence: true
  validates :password, presence: true

  def initialize(params = {})
    if params.present?
      params = permit_params(params)
    end
    super
  end

  def login_enable?
    user = target_user
    if self.valid? && user && user.authenticate(password)
      user
    else
      false
    end
  end

  private

  def permit_params(params)
    params.fetch(:user).permit(:userid, :password)
  end

  def target_user
    User.find_by(userid: userid)
  end
end

