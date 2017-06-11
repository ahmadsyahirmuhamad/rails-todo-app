class Api::App::V1::UsersController < Api::App::V1::BaseController

  def index
    render( json:
      {
        token: current_user.generate_auth_token,
        users: current_user.attributes,
        message: "User Details",
        error: false
      }, status: 200)
  end

  def update
    if current_user.update_attributes(session_params)
      response = {
        token: current_user.generate_auth_token,
        users: current_user.attributes,
        message: "User Update Success",
        error: false
      }
    else
      response = {
        token: current_user.generate_auth_token,
        users: current_user.attributes,
        message: "User Update Failed",
        error: true
      }
    end
    render( json: response, status: 200)
  end

  def session_params
    params.require(:user).permit(:email, :password, :first_name, :last_name)
  end
end
