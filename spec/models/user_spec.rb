require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) do
    @user = User.new
    @user.nickname = 'nickname'
    @user.email = 'email@email.em'
    @user.password = 'password'
  end

  it "should return nickname error message" do
    @user.nickname = nil
    expect(@user.errors.messages['nickname']).to_not be_nil
  end

  it "should return email error message" do
    @user.email = nil
    expect(@user.errors.messages['email']).to_not be_nil
  end

  it "should return user error message" do
    @user.password = nil
    expect(@user.errors.messages['password']).to_not be_nil
  end

  it "should be valid" do
    expect(@user).to be_valid
  end
end
