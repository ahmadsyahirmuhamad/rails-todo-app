class Api::App::V1::TodosController < Api::App::V1::BaseController

  before_action :current_todo, only: [:update, :destroy, :complete]

  def index
    response = {
        todos: current_user.todos,
        message: "Todos list",
        error: false
      }
    render( json: response, status: 200)
  end

  def create
    todo = current_user.todos.create(todos_params)
    if todo.valid?
      response = {
        todos: todo.attributes,
        message: "Create Todo Success",
        error: false
      }
    else
      response = {
        todos: "",
        message: "Create Todo failed",
        error: true
      }
    end
    render( json: response, status: 200)
  end

  def update
    @todo.update_attributes(todos_params)
    if @todo.valid?
      response = {
        todos: @todo.attributes,
        message: "Create Todo Success",
        error: false
      }
    else
      response = {
        todos: @todo.attributes,
        message: "Create Todo failed",
        error: true
      }
    end
    render( json: response, status: 200)
  end

  def destroy
    if @todo.destroy
      response = {
        todos: "",
        message: "destroy Todo Success",
        error: false
      }
    else
      response = {
        todos: @todo.attributes,
        message: "destroy Todo failed",
        error: true
      }
    end
    render( json: response, status: 200)
  end

  def complete
    @todo.update_attributes(todos_params)
    if @todo.valid?
      response = {
        todos: @todo.attributes,
        message: "update complete Todo Success",
        error: false
      }
    else
      response = {
        todos: @todo.attributes,
        message: "update complete Todo failed",
        error: true
      }
    end
    render( json: response, status: 200)
  end

  private

  def todos_params
    params.require(:todo).permit(:title, :description, :complete)
  end

  def current_todo
    @todo = Todo.find_by(id: params[:id])
  end
end
