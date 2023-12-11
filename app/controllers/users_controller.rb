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
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      flash[:success] = "Welcome, #{user.name}!"
      redirect_to user_path(user)
    else
      flash[:error] = "Incorrect Email or Password."
      render :login_form
    end
  end

  def create 
    user = User.create(name: params[:user][:name], email: params[:user][:email], password: params[:user][:password])
    if password_matches?(params) && user.save
      redirect_to user_path(user)
    elsif !password_matches?(params)
      redirect_to register_path
      flash[:alert] = "Error: Passwords do not match"
    else
      flash[:error] = user.errors.full_messages.to_sentence
      redirect_to register_path
    end
  end 

  private 

  def user_params 
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def password_matches?(params)
    params[:user][:password] == params[:user][:password_confirmation]
  end
end 