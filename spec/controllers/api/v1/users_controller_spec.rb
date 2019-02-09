require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
let(:correct_edit) { {params: {id: 3 }}}

  describe "GET #edit" do
    it "returns http success" do
      get :edit, correct_edit
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #update" do
    it "returns http success" do
      put :update, correct_edit
      expect(response).to have_http_status(:success)
    end
  end

end
