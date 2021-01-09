class LoginForm
  include ActiveModel::Model
  include ActiveModel::Serialization
  include ActiveModel::Attributes
  extend ActiveModel::Translation

  attribute :id, :string
  attribute :password, :string

  validates :id, presence: true
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
    params.fetch(:user).permit(:id, :password)
  end

  def target_user
    User.find_by(id: id.downcase)
  end
end

