class ApplicationController < ActionController::API
  private

  def authenticate_user!
    token = request.headers['Authorization'].split(' ').last
    payload = JWT.decode(token, 'your_secret_key', true, algorithm: 'HS256').first
    @current_user = User.find(payload['user_id'])
  rescue JWT::DecodeError
    render json: { error: 'Invalid token' }, status: :unauthorized
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'User not found' }, status: :unauthorized
  end
end
