class ApplicationController < ActionController::API
  def encode_token(payload)
    JWT.encode(payload, 'your_secret_key') # Replace with your actual secret key
  end

  def decode_token(token)
    return unless token

    begin
      JWT.decode(token.split(' ')[1], 'your_secret_key')[0] # Adjust as necessary
    rescue JWT::DecodeError
      nil
    end
  end

  def authorized_user
    decoded_token = decode_token(request.headers['Authorization'])
    @current_user = User.find(decoded_token['user_id']) if decoded_token
  rescue
    render json: { error: 'Not authorized' }, status: :unauthorized
  end
end
