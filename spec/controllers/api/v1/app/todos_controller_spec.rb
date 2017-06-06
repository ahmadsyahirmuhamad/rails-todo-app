require'rails_helper'

describe Api::V1::App::TodosController do

  describe 'Api::V1::App::TodosController' do
    before(:each) do
      @user = create(:user)
      @todo = create(:todo, user_id: @user.id)
      auth_token = @user.generate_auth_token
      request.headers['Authorization'] = auth_token
    end

    context 'POST #create' do
      it 'with valid attributes' do
        params = { todo: { title: "title", description: "description" } }
        post :create, params
        expect(response.status).to eql(200)
        expect(JSON.parse(response.body)['error']).to eql(false)
      end

      it 'with invalid attributes' do
        params = { todo: { title: "", description: "" } }
        post :create, params
        expect(response.status).to eql(200)
        expect(JSON.parse(response.body)['error']).to eql(true)
      end
    end

    context 'PUT #update' do
      it 'with valid attributes' do
        params = { id: @todo.id, todo: { title: "new title", description: "new description" } }
        put :update, params
        @todo.reload
        expect(response.status).to eql(200)
        expect(JSON.parse(response.body)['error']).to eql(false)
        expect(JSON.parse(response.body)['todo']['title']).to eql(@todo.title)
        expect(JSON.parse(response.body)['todo']['description']).to eql(@todo.description)
      end

      it 'with invalid attributes' do
        params = { id: @todo.id, todo: { title: "", description: "new description" } }
        put :update, params
        @todo.reload
        expect(response.status).to eql(200)
        expect(JSON.parse(response.body)['error']).to eql(true)
        expect(JSON.parse(response.body)['todo']['title']).to_not eql(@todo.title)
        expect(JSON.parse(response.body)['todo']['description']).to_not eql(@todo.description)
      end
    end

    context 'DELETE #destroy' do
      it 'with valid attributes' do
        @count = Todo.count
        params = { id: @todo.id }
        delete :destroy, params
        expect(response.status).to eql(200)
        expect(JSON.parse(response.body)['error']).to eql(false)
        expect(@count - 1).to eql(Todo.count)
      end
    end

  end
end