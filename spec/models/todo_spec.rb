require 'rails_helper'

describe Todo do

  it "is valid with a user_id, title, description" do
    expect(build(:todo)).to be_valid
  end

  it "is invalid without user_id" do
    todo = build(:todo, user_id: "")
    expect(todo).to_not be_valid
    expect(todo.errors[:user_id]).to include("can't be blank")
  end

  it "is invalid without title" do
    todo = build(:todo, title: "")
    expect(todo).to_not be_valid
    expect(todo.errors[:title]).to include("can't be blank")
  end

  it "is invalid without description" do
    todo = build(:todo, description: "")
    expect(todo).to_not be_valid
    expect(todo.errors[:description]).to include("can't be blank")
  end

end

