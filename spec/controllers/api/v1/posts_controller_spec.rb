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
      it 'should return error message with body' do
        request.headers["Authorization"] = @token
        resp = post :create, incorrect_create_post
        expect(JSON.parse(resp.body)['errors']).to include('body')
      end

      it 'should return created post' do
        request.headers["Authorization"] = @token
        resp = post :create, correct_create_post
        expect(JSON.parse(resp.body)['id']).to_not be_nil
        expect(JSON.parse(resp.body)['title']).to eq('example title')
        expect(JSON.parse(resp.body)['body']).to eq('example body')
        expect(JSON.parse(resp.body)['author_nickname']).to eq(@user.nickname)
      end
    end
  end

  before (:all) do
    @posts = create_list(:post,5)
  end

  let(:correct_show_post) { {params: {id: @posts.last.id}}}
  let(:incorrect_show_post) { {params: {id: @posts.last.id+1}}}
  let(:correct_index_post) { {params: {page: 1, per_page: 3}}}
  let(:incorrect_index_post) { {params: {page: 10, per_page: 10}}} #if posts < 90
  
  describe 'post show' do
    context 'when user authorised' do
      it 'should return error message' do
        request.headers["Authorization"] = @token
        resp = get :show, incorrect_show_post
        expect(JSON.parse(resp.body)['errors']).to_not be_nil
      end

      it 'should return post' do
        request.headers["Authorization"] = @token
        resp = get :show, correct_show_post
        expect(JSON.parse(resp.body)['title']).to eq(@posts.last.title)
      end
    end
  end

  describe 'posts index' do
    it 'should return error message' do
      request.headers["Authorization"] = @token
      resp = get :index, correct_index_post
      expect(JSON.parse(resp.body)).to eq({})
    end
  end
end
