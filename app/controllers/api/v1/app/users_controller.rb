class Api::V1::App::UsersController < Api::V1::App::BaseController

  def index
    render( json:
      {
        token: current_user.generate_auth_token,
        users: current_user.attributes,
        message: "User Details",
        error: false
      }, status: 200)
  end

  def session_params
    params.require(:user).permit(:email, :password, :first_name, :last_name)
  end
end
