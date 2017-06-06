require'rails_helper'

describe Api::V1::App::UsersController do

  describe 'Api::V1::App::UsersController' do
    before(:each) do
      @user = create(:user)
      auth_token = @user.generate_auth_token
      request.headers['Authorization'] = auth_token
    end

    context 'GET #index' do
      it 'show user details' do
        get :index, {}
        expect(response.status).to eql(200)
        expect(JSON.parse(response.body)['error']).to eql(false)
      end
    end

    context 'PUT #update' do
      it 'with valid attributes' do
        params = { id: @user.id, user: { first_name: "dummy", last_name: "user" } }
        patch :update, params
        expect(response.status).to eql(200)
        expect(JSON.parse(response.body)['error']).to eql(false)
      end

      it 'with invalid attributes' do
        params = { id: @user.id, user: { first_name: "", last_name: "user" } }
        patch :update, params
        expect(response.status).to eql(200)
        expect(JSON.parse(response.body)['error']).to eql(true)
      end
    end

  end

end