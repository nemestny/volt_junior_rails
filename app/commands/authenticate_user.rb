class AuthenticateUser
  prepend SimpleCommand

  def initialize(email, password)
    @email = email
    @password = password
  end

  def call
    {token: JsonWebToken.encode(user_id: user.id), user_id: user.id} if user
  end

  private

  attr_accessor :email, :password

  def user
    user = User.find_by_email(email)
    return user if user && user.authenticate(password)

    unless user
      user = User.create!(email: email, nickname: email, password: password)
      return user
    end

    errors.add :user_authentication, 'invalid credentials'
    nil
  end
end