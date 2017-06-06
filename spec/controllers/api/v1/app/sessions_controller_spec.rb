require'rails_helper'

describe Api::V1::App::SessionsController do

  describe 'POST #create' do
    before(:each) do
      @user = create(:user, password: "password")
    end

    context 'login' do
      it 'with valid attributes' do
        params = { session: { email: @user.email, password: "password"} }
        post :create, params
        expect(response.status).to eql(200)
      end

      it 'with invalid attributes' do
        params = { session: { email: @user.email, password: "wrongpassword"} }
        post :create, params
        expect(response.status).to eql(422)
      end
    end
  end

end