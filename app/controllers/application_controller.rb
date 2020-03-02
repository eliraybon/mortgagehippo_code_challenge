class ApplicationController < ActionController::API

  def authenticate
    token = request.headers['token'] || request.headers['key']
    @current_user = User.find_by(api_key: token)
    render json: ["Invalid credentials"] if @current_user.nil?
  end

end
