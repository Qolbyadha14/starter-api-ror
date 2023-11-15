class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  def render_unprocessable_entity_response(exception)
    render json: exception.record.errors, status: :unprocessable_entity
  end

  def render_not_found_response
    render json: { error: "record not found" }, status: :not_found
  end

  private

  def authenticate_user!
    token = request.headers['authorization'].split(' ').last
    payload = JWT.decode(token, 'your_secret_key', true, algorithm: 'HS256').first
    @current_user = User.find(payload['user_id'])
  rescue JWT::DecodeError
    render json: { error: 'Invalid token' }, status: :unauthorized
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'User not found' }, status: :unauthorized
  end
end
