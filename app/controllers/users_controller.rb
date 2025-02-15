class UsersController < ApplicationController

  # Before executing the actions :show, :edit, :update, and :destroy,
  # load the user using the set_user method.
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users/new
  # Display the registration form.
  def new
    @user = User.new
  end

  # POST /users
  # Process the registration form submission.
  def create
    @user = User.new(user_params)
    if @user.save
      render json: { message: 'User successfully created', user: @user }, status: :created
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end


  # GET /users/:id
  # Display the user's details.
  def show
  end

  # GET /users/:id/edit
  # Display the edit form for the user.
  def edit
  end

  # PATCH/PUT /users/:id
  # Process the edit form submission and update the user.
  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'User successfully updated!'
    else
      render :edit
    end
  end

  # DELETE /users/:id
  # Delete the user record.
  def destroy
    @user.destroy
    redirect_to root_path, notice: 'User successfully deleted!'
  end

  private

  # Callback to set the user based on the ID parameter.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end
