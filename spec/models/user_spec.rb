require 'rails_helper'

describe User do

  it "is valid with a email and password" do
    expect(build(:user)).to be_valid
  end

  it "is invalid without email" do
    user = build(:user, email: "")
    expect(user).to_not be_valid
    expect(user.errors[:email]).to include("can't be blank")
  end

  it "is invalid without password" do
    user = build(:user, password: "")
    expect(user).to_not be_valid
    expect(user.errors[:password]).to include("can't be blank")
  end

  it "is invalid with duplicate email" do
    user1 = create(:user, email: "user@email.com")
    user2 = build(:user, email: "user@email.com")
    expect(user2).to_not be_valid
    expect(user2.errors[:email]).to include("has already been taken")
  end

  it "is valid with first_name and last_name on update" do
    user = create(:user)
    user.update_attributes(first_name: "dummy", last_name: "user")
    expect(user).to be_valid
  end

  it "is invalid without first_name on update" do
    user = create(:user)
    user.update_attributes(first_name: "", last_name: "user")
    expect(user.errors[:first_name]).to include("can't be blank")
  end

  it "is invalid without last_name on update" do
    user = create(:user)
    user.update_attributes(first_name: "dummy", last_name: "")
    expect(user.errors[:last_name]).to include("can't be blank")
  end

  it "is invalid without last_name on update" do
    user = create(:user)
    auth_token = user.generate_auth_token
    expect(auth_token).to_not be_nil
  end

end

