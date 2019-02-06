require 'rails_helper'

RSpec.describe Post, type: :model do
  before(:each) do
    @post = Post.new
    @post.title = 'title'
    @post.body = 'body'
    @post.user = create(:user)
  end

  it "should return title error message" do
    @post.title = nil
    expect(@post.errors.messages['title']).to_not be_nil
  end

  it "should return body error message" do
    @post.body = nil
    expect(@post.errors.messages['body']).to_not be_nil
  end

  it "should return user error message" do
    @post.user = nil
    expect(@post.errors.messages['user']).to_not be_nil
  end

  it "should be valid" do
    expect(@post).to be_valid
  end
end
