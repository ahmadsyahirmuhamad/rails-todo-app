require'rails_helper'

describe Api::App::V1::TodosController do

  describe 'Api::V1::App::TodosController' do
    before(:each) do
      @user = create(:user)
      @todo = create(:todo, user_id: @user.id)
      auth_token = @user.generate_auth_token
      request.headers['Authorization'] = auth_token
    end

    context 'get #index' do
      it 'with valid attributes' do
        get :index
        expect(response.status).to eql(200)
        expect(@user.todos.count).to eql(1)
        expect(JSON.parse(response.body)['error']).to eql(false)
      end
    end

    context 'POST #create' do
      it 'with valid attributes' do
        params = { todo: build(:todo, user_id: @user.id).attributes }
        post :create, params
        expect(response.status).to eql(200)
        expect(@user.todos.count).to eql(2)
        expect(JSON.parse(response.body)['error']).to eql(false)
      end

      it 'with invalid attributes' do
        params = { todo: build(:todo, title: "", description: "", user_id: @user.id).attributes }
        post :create, params
        expect(response.status).to eql(200)
        expect(@user.todos.count).to eql(1)
        expect(JSON.parse(response.body)['error']).to eql(true)
      end
    end

    context 'PUT #update' do
      it 'with valid attributes' do
        params = { id: @todo.id, todo: { title: "new title", description: "new description" } }
        put :update, params
        @todo.reload
        expect(response.status).to eql(200)
        expect(@user.todos.count).to eql(1)
        expect(JSON.parse(response.body)['error']).to eql(false)
        expect(JSON.parse(response.body)['todo']['title']).to eql(@todo.title)
        expect(JSON.parse(response.body)['todo']['description']).to eql(@todo.description)
      end

      it 'with invalid attributes' do
        params = { id: @todo.id, todo: { title: "", description: "new description" } }
        put :update, params
        @todo.reload
        expect(response.status).to eql(200)
        expect(@user.todos.count).to eql(1)
        expect(JSON.parse(response.body)['error']).to eql(true)
        expect(JSON.parse(response.body)['todo']['title']).to_not eql(@todo.title)
        expect(JSON.parse(response.body)['todo']['description']).to_not eql(@todo.description)
      end
    end

    context 'DELETE #destroy' do
      it 'with valid attributes' do
        params = { id: @todo.id }
        delete :destroy, params
        expect(response.status).to eql(200)
        expect(JSON.parse(response.body)['error']).to eql(false)
        expect(@user.todos.count).to eql(0)
      end
    end

    context 'PUT #complete' do
      it 'with valid attributes' do
        params = { id: @todo.id, todo: { complete: true } }
        put :update, params
        @todo.reload
        expect(response.status).to eql(200)
        expect(JSON.parse(response.body)['error']).to eql(false)
        expect(JSON.parse(response.body)['todo']['complete']).to eql(true)
      end

      it 'with invalid attributes' do
        params = { id: @todo.id, todo: { title: "" } }
        put :update, params
        @todo.reload
        expect(response.status).to eql(200)
        expect(JSON.parse(response.body)['error']).to eql(true)
        expect(JSON.parse(response.body)['todo']['complete']).to eql(false)
      end
    end

  end
end