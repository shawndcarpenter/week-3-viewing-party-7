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
    if user.authenticate(params[:password])
      flash[:success] = "Welcome, #{user.name}!"
      redirect_to user_path(user)
    else
      flash[:error] = "Incorrect Email or Password."
      render :login_form
    end
  end

  def create 
    if params[:user][:password] == params[:user][:confirm_password]   
      user = User.create(name: params[:user][:name], email: params[:user][:email], password: params[:user][:password])
      if user.save
        redirect_to user_path(user)
      else  
        flash[:error] = user.errors.full_messages.to_sentence
        redirect_to register_path
      end 
    else
      redirect_to register_path
      flash[:alert] = "Error: Passwords do not match"
    end
  end 

  private 

  def user_params 
    params.require(:user).permit(:name, :email, :password, :confirm_password)
  end 
end 