class UsersController <ApplicationController 
  def new 
    @user = User.new()
  end 

  def show 
    @user = User.find(params[:id])
  end 

  def login_form
  end

  def login
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:success] = "Welcome, #{@user.name}!"
      redirect_to user_path(@user)
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
      redirect_to user_path(user)
    else
      flash[:error] = user.errors.full_messages.to_sentence
      redirect_to register_path
    end
  end 

  private 

  def user_params 
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end 