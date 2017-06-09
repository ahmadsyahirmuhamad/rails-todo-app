require'rails_helper'

describe Api::App::V1::RegisterController do

  describe 'POST #create' do

    context 'register' do
      it 'with valid attributes' do
        params = { user: { email: "dummy@user.com", password: "password", password_confirmation: "password"} }
        post :create, params
        expect(User.count).to eql(1)
        expect(response.status).to eql(200)
      end

      it 'with invalid attributes' do
        params = { user: { email: "", password: "" } }
        post :create, params
        expect(User.count).to eql(0)
        expect(response.status).to eql(200)
      end
    end
  end

end