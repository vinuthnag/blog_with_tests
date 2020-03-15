class UsersController < ApplicationController
   before_action :set_user, only: [:show, :edit, :update, :destroy]
    skip_before_action :validate_current_user, only: [:index,:login,:create,:new]

  
  def index
    # @users = User.all
  end

  
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    @user.avatar.attach(params[:avatar])
    respond_to do |format|
    if @user.save
      format.html { redirect_to users_url, notice: 'User was successfully created.' }
    else
      format.html { render :new}
    end
  end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      @user.avatar.purge if params[:user][:avatar].present?
      @user.avatar.attach(params[:user][:avatar])
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def login
    user = User.authenticate(params[:email],params[:password])
      if user.present?
      session[:user_id] = user.id
      flash[:notice] = "welcome #{user.name}"
      redirect_to posts_path
    else
      flash[:notice] = "email or password doesn't match."
      redirect_to users_path
    end
  end
  def logout
    session[:user_id] = nil
    flash[:notice] = "You are Logged out"
    redirect_to root_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation,:avatar)
    end
end
