class Api::App::V1::SessionsController < Api::App::V1::BaseController

  skip_before_action :authenticate_request

  def create

    user = User.find_by(email: session_params[:email]).try(:authenticate, session_params[:password])
    return render( json: { users: "", message: "Error logging in", error: true }, status: 422) unless user
    render( json:
      {
        token: user.generate_auth_token,
        users: user.attributes,
        message: "You're logged in. Welcome back!",
        error: false
      }, status: 200)
  end

  def session_params
    params.require(:session).permit(:email, :password)
  end
end
