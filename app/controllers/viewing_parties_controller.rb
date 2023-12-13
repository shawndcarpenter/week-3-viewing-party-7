class ViewingPartiesController < ApplicationController 
  rescue_from ActiveRecord::RecordNotFound, with: :not_found_response

  def new
    @user = User.find(session[:user_id])
    @movie = Movie.find(params[:movie_id])

    unless @user == current_user?
      redirect_to "/movies/#{params[:movie_id]}"
      flash[:error] = "You must be logged in or registered to create a movie party."
    end
  end 
  
  def create 
    @user = User.find(session[:user_id])

    @user.viewing_parties.create(viewing_party_params)
    redirect_to dashboard
  end 

  private 
  def not_found_response
    redirect_to "/movies/#{params[:movie_id]}"
    flash[:error] = "You must be logged in or registered to create a movie party."
  end

  def viewing_party_params 
    params.permit(:movie_id, :duration, :date, :time)
  end 
end 