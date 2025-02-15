class SessionsController < ApplicationController


  def new
  end

  # POST /login
  def create
    # 查找用户
    user = User.find_by(username: params[:username])

    # 如果未找到用户，返回用户不存在的错误
    if user.nil?
      render json: { error: 'User not found' }, status: :unprocessable_entity
      return
    end

    # 验证用户密码
    if user.authenticate(params[:password])
      # 登录成功，返回用户信息（可以添加 token 或 session 信息）
      render json: { message: 'Login successful', user: user }, status: :ok
    else
      # 密码错误
      render json: { error: 'Invalid password' }, status: :unprocessable_entity
    end
  end



  def destroy
  end
end
