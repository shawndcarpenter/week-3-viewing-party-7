class UsersController <ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :not_found_response

  def new 
    @user = User.new()
  end 

  def show 
    @user = User.find(session[:user_id])
    unless @user && @user == current_user?
      redirect_to root_path
      flash[:error] = "You must be logged in or registered to access the dashboard."
    end
  end 

  def login_form
  end

  def login
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:success] = "Welcome, #{@user.name}!"
      redirect_to dashboard_path
    else
      redirect_to login_path
      flash[:error] = "Incorrect Email or Password."
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to root_path
  end

  def create 
    user = User.create(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to dashboard_path
    else
      flash[:error] = user.errors.full_messages.to_sentence
      redirect_to register_path
    end
  end 

  private 
  def not_found_response
    redirect_to root_path
    flash[:error] = "You must be logged in or registered to access the dashboard."
  end

  def user_params 
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end 