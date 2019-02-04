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
    user = create(:user)
    @token = JsonWebToken.encode(user_id: user.id)
  end

  describe 'post create' do
    context 'when user authorised' do
      it 'should return error message' do
        request.headers["Authorization"] = @token
        resp = get :index
        expect(JSON.parse(resp.body)).to eq({})
      end
    end
  end
end
