class Api::App::V1::RegisterController < Api::App::V1::BaseController

  skip_before_action :authenticate_request

  def create
    user = User.create(user_params)
    if user.persisted?
      response = {
        token: user.generate_auth_token,
        users: user.attributes,
        message: "Register Success",
        error: false
      }
    else
      response = {
        token: "",
        users: [],
        message: "Register Failed",
        error: true
      }
    end
    render( json: response, status: 200 )
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
