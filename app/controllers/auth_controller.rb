class AuthController < ApplicationController
  def signup
    @user = User.new(user_params)
    if @user.save
      token = encode_token({ user_id: @user.id })
      UserNotificationJob.perform_later(@user)
      render json: { user: @user, token: token }, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def login
    @user = User.find_by(email: params[:email])
    if @user&.authenticate(params[:password])
      token = encode_token({ user_id: @user.id })
      render json: { user: @user, token: token }
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
