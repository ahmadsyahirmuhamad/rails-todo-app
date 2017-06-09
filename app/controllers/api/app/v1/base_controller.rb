class Api::App::V1::BaseController < Api::App::V1::ApplicationController
  before_action :authenticate_request

  def http_auth_header_content
    request.headers['Authorization'] if request.headers['Authorization'].present?
  end

  protected
  def authenticate_request
    render(json: { error: 'Not Authorized'}, status: 401) unless current_user
  end

  def current_user
    decoded_auth_token ||= AuthTokenServices.decode(http_auth_header_content)
    User.find_by(id: decoded_auth_token["user_id"]) if decoded_auth_token
  end
end
