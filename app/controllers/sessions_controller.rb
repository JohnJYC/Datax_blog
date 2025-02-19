class SessionsController < ApplicationController
  def new
  end

  # POST /login
  def create
    # 根据用户名查找用户
    user = User.find_by(username: params[:username])
    if user.nil?
      render json: { error: 'User not found' }, status: :unprocessable_entity and return
    end

    # 验证密码
    if user.authenticate(params[:password])
      # 登录成功，生成 JWT token，有效期 24 小时
      payload = { user_id: user.id, exp: 24.hours.from_now.to_i }
      token = JWT.encode(payload, Rails.application.secret_key_base)

      # 返回 token 和用户的基本信息
      render json: {
        message: 'Login successful',
        token: token,
        user: { id: user.id, username: user.username }
      }, status: :ok
    else
      render json: { error: 'Invalid password' }, status: :unprocessable_entity
    end
  end

  def destroy
    # 如果使用 session 登录
    reset_session
    render json: { message: 'Logged out successfully' }, status: :ok
  end
end
