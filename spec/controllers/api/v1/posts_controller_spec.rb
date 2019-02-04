require 'rails_helper'
# require 'jwt'

RSpec.describe Api::V1::PostsController, type: :controller do

  describe 'any action' do
    context 'when user not authorised' do
      it 'should return error message' do
        resp = post :create
        # p resp.body
        expect(JSON.parse(resp.body)['error']).to eq('Not Authorized')
      end
    end
  end

  before (:all) do
    @user = create(:user)
    @token = JsonWebToken.encode(user_id: @user.id)
  end

  let(:correct_create_post) { {params: {title: 'example title', body: 'example body', published_at: Time.now }}}
  let(:incorrect_create_post) { {params: {title: 'example title'}}}


  describe 'post create' do
    context 'when user authorised' do
      it 'should return error message' do
        request.headers["Authorization"] = @token
        resp = post :create, incorrect_create_post
        puts resp.body
        expect(JSON.parse(resp.body)['title']).to eq('example title')
        expect(JSON.parse(resp.body)['body']).to eq('example body')
        expect(JSON.parse(resp.body)['author_nickname']).to eq(@user.nickname)
      end

      it 'should return error message' do
        request.headers["Authorization"] = @token
        resp = post :create, correct_create_post
        puts resp.body
        expect(JSON.parse(resp.body)['title']).to eq('example title')
        expect(JSON.parse(resp.body)['body']).to eq('example body')
        expect(JSON.parse(resp.body)['author_nickname']).to eq(@user.nickname)
      end
    end
  end
end
